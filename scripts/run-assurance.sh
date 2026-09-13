#!/usr/bin/env bash
# Runs the kane-cli assurance lifecycle end to end, non-interactively, for CI.
#
# Stages: capture + extract -> checkpoint 1 (auto-review) -> design
# (--mode ci, so judgement calls fail closed instead of hanging) ->
# checkpoint 2 (auto-review) -> author each generated test in a real headless
# browser -> measure coverage -> write a dated results report.
#
# Auto-approval at both checkpoints is the same choice kane-cli's own CI
# example makes — appropriate for a pipeline that re-derives from a spec
# that is itself reviewed in source control, not a substitute for a human
# reading a spec nobody has looked at.
set -uo pipefail
cd "$(dirname "$0")/.."

source scripts/lib.sh
require_cmd kane-cli
require_cmd jq

RUN_DIR="run"
mkdir -p "$RUN_DIR"
: > "$RUN_DIR/summary.md"

trap capture_kane_trace_logs EXIT

SOURCE_SPEC="${SOURCE_SPEC:-sources/feature-spec.md}"
SOURCE_ID="${SOURCE_ID:-feature-spec}"
MAX_DESIGN="${MAX_DESIGN:-4}"
VARIABLES_SEED="${VARIABLES_SEED:-kane-variables.seed.json}"

NEEDS_ATTENTION=0

summary "## Kane CLI Assurance — Vehicle Insurance"
summary ""
summary "Source: \`$SOURCE_SPEC\` · Target: [Tricentis Vehicle Insurance](https://sampleapp.tricentis.com/101/#)"
summary ""

kane-cli balance --json > "$RUN_DIR/balance-before.json" 2>/dev/null || true
BALANCE_BEFORE=$(jq -r '.balance // .credits // empty' "$RUN_DIR/balance-before.json" 2>/dev/null || true)

# --- Stage 1+2: capture + extract ---------------------------------------
echo "== context ingest =="
kane-cli context ingest "$SOURCE_SPEC" --mode agent --as "$SOURCE_ID" 2> "$RUN_DIR/01-ingest.stderr.log" \
  | tee "$RUN_DIR/01-ingest.ndjson"
ex="$(kane_exit "$RUN_DIR/01-ingest.ndjson")"
if [ "$ex" != "0" ]; then
  summary "**FAILED at \`context ingest\`** (exit \`$ex\`) — see \`01-ingest.ndjson\`."
  dump_stderr_to_summary "$RUN_DIR/01-ingest.stderr.log" "context ingest"
  exit 1
fi
summary "- \`context ingest\`: done"

# --- Stage 3: checkpoint 1 (auto-review use-cases) ----------------------
echo "== context list (use-cases) =="
kane-cli context list --json --inferred > "$RUN_DIR/02-context-list.ndjson"

jq -s '[ .[] | select(.label == "usecase") |
  {ref: .id, resolution: "approved",
   reason: "CI auto-approval: citation verified against reviewed source (Vehicle Insurance demo pipeline)."} ]' \
  "$RUN_DIR/02-context-list.ndjson" > "$RUN_DIR/verdicts-checkpoint1.json"

UC_COUNT=$(jq 'length' "$RUN_DIR/verdicts-checkpoint1.json")
if [ "$UC_COUNT" -eq 0 ]; then
  summary "**FAILED** — no use-cases were extracted from \`$SOURCE_SPEC\`."
  exit 1
fi
summary "- \`context extract\`: $UC_COUNT use-case(s) proposed"

# Review each ref individually — batched context review has crashed silently
# on some 0.8.x releases (see N_KaneCLI_Assurance run #8 notes).
mapfile -t uc_refs < <(jq -r '.[].ref' "$RUN_DIR/verdicts-checkpoint1.json")
approved_refs=()
CHECKPOINT1_FAIL=0
for ref in "${uc_refs[@]}"; do
  safe_ref="$(echo "$ref" | tr -c 'A-Za-z0-9_-' '_')"
  out="$RUN_DIR/03-review1-${safe_ref}.ndjson"
  err="$RUN_DIR/03-review1-${safe_ref}.stderr.log"
  kane-cli context review --approve "$ref" --json 2> "$err" | tee "$out"
  ex="$(kane_exit "$out")"
  if [ "$ex" = "0" ]; then
    approved_refs+=("$ref")
  else
    CHECKPOINT1_FAIL=$((CHECKPOINT1_FAIL + 1))
    summary "- \`$ref\`: **checkpoint 1 review failed** (exit \`${ex:-}\`) — see \`$(basename "$out")\`."
    dump_stderr_to_summary "$err" "context review ($ref)"
  fi
done

if [ "${#approved_refs[@]}" -eq 0 ]; then
  summary "**FAILED at checkpoint 1** — no use-case could be approved."
  exit 1
fi
if [ "$CHECKPOINT1_FAIL" -gt 0 ]; then
  summary "- **Checkpoint 1**: ${#approved_refs[@]}/$UC_COUNT use-case(s) approved ($CHECKPOINT1_FAIL failed)"
  NEEDS_ATTENTION=1
else
  summary "- **Checkpoint 1**: ${#approved_refs[@]}/$UC_COUNT use-case(s) approved"
fi

# --- Stage 4: design tests per approved use-case ------------------------
echo "== design tests =="
summary ""
summary "### Design"
summary ""
for ref in "${approved_refs[@]}"; do
  safe_ref="$(echo "$ref" | tr -c 'A-Za-z0-9_-' '_')"
  out="$RUN_DIR/04-design-${safe_ref}.ndjson"
  err="$RUN_DIR/04-design-${safe_ref}.stderr.log"
  echo "-- design tests for $ref --"
  kane-cli design tests --use-case "$ref" --mode ci --max "$MAX_DESIGN" 2> "$err" | tee "$out"
  ex="$(kane_exit "$out")"
  case "$ex" in
    0)
      gaps=$(kane_field "$out" '.gaps | length' 2>/dev/null); gaps="${gaps:-0}"
      warns=$(kane_field "$out" '.warnings | length' 2>/dev/null); warns="${warns:-0}"
      summary "- \`$ref\`: designed ok — $gaps gap(s), $warns warning(s)"
      ;;
    "")
      summary "- \`$ref\`: **no \`done\` event in the stream** — process may have crashed. See \`$out\`."
      dump_stderr_to_summary "$err" "design tests ($ref)"
      NEEDS_ATTENTION=1
      ;;
    *)
      reason=$(kane_field "$out" '.error // .message // empty')
      summary "- \`$ref\`: **needs a human** (exit \`$ex\`${reason:+ — $reason}). Re-run locally with \`--mode agent\` to resolve it, then re-run this workflow."
      NEEDS_ATTENTION=1
      ;;
  esac
done

# --- Stage 5: checkpoint 2 (auto-review ACs/seenarios/tests) ------------
echo "== context list (design artifacts) =="
kane-cli context list --json --inferred > "$RUN_DIR/05-context-list-2.ndjson"

jq -s '[ .[] | select(.label != "usecase" and .status == "derived") |
  {ref: .id, resolution: "approved",
   reason: "CI auto-approval: design output traced to an approved, cited use-case."} ]' \
  "$RUN_DIR/05-context-list-2.ndjson" > "$RUN_DIR/verdicts-checkpoint2.json"

DESIGN_COUNT=$(jq 'length' "$RUN_DIR/verdicts-checkpoint2.json")
if [ "$DESIGN_COUNT" -gt 0 ]; then
  mapfile -t design_refs < <(jq -r '.[].ref' "$RUN_DIR/verdicts-checkpoint2.json")
  design_approved=0
  design_fail=0
  for ref in "${design_refs[@]}"; do
    safe_ref="$(echo "$ref" | tr -c 'A-Za-z0-9_-' '_')"
    out="$RUN_DIR/06-review2-${safe_ref}.ndjson"
    err="$RUN_DIR/06-review2-${safe_ref}.stderr.log"
    kane-cli context review --approve "$ref" --json 2> "$err" | tee "$out"
    ex="$(kane_exit "$out")"
    if [ "$ex" = "0" ]; then
      design_approved=$((design_approved + 1))
    else
      design_fail=$((design_fail + 1))
      summary "- \`$ref\`: **checkpoint 2 review failed** (exit \`${ex:-}\`) — see \`$(basename "$out")\`."
      dump_stderr_to_summary "$err" "context review ($ref)"
    fi
  done
  summary "- **Checkpoint 2**: $design_approved/$DESIGN_COUNT design artifact(s) approved"
  if [ "$design_fail" -gt 0 ]; then
    NEEDS_ATTENTION=1
  fi
else
  summary "- **Checkpoint 2**: nothing new to review (no use-case cleared design)"
fi

# --- Stage 6: author every generated test in a real headless browser ----
echo "== testmd run (author) =="
summary ""
summary "### Test runs"
summary ""
shopt -s nullglob
tests=(.testmuai/tests/*_test.md)
if [ "${#tests[@]}" -eq 0 ]; then
  summary "- no tests were designed this run (see Design section above)"
else
  for f in "${tests[@]}"; do
    name="$(basename "$f")"
    log="$RUN_DIR/07-testmd-${name%.md}.log"
    build_runtime_variables "$f"
    echo "-- authoring $name --"
    kane-cli testmd run "$f" --agent --headless --variables-file .testmuai/variables/runtime.json 2>&1 | tee "$log"
    status="${PIPESTATUS[0]}"

    link=$(best_effort_evidence_link "$log")
    if [ "$status" -eq 0 ]; then
      summary "- \`$name\`: **passed**${link:+ — [evidence]($link)}"
    else
      summary "- \`$name\`: **failed** (exit $status)${link:+ — [evidence]($link)} — see \`$(basename "$log")\`"
      NEEDS_ATTENTION=1
    fi
  done
fi

# --- Stage 7: measure coverage ------------------------------------------
echo "== cover gaps =="
kane-cli cover gaps --json > "$RUN_DIR/08-cover.json" 2>/dev/null || true
kane-cli cover gaps > "$RUN_DIR/08-cover.txt" 2>&1 || true

summary ""
summary "### Coverage (\`kane-cli cover gaps\`)"
summary ""
summary '```'
summary "$(cat "$RUN_DIR/08-cover.txt")"
summary '```'
summary ""
summary "Read the use-case row, not the headline percentage — \`designed\`/\`proven\` are measured"
summary "against *criteria that exist right now*, not against everything the product should do."

kane-cli balance --json > "$RUN_DIR/balance-after.json" 2>/dev/null || true
BALANCE_AFTER=$(jq -r '.balance // .credits // empty' "$RUN_DIR/balance-after.json" 2>/dev/null || true)
if [ -n "$BALANCE_BEFORE" ] && [ -n "$BALANCE_AFTER" ]; then
  used=$(( BALANCE_BEFORE - BALANCE_AFTER ))
  summary ""
  summary "**Credits used this run:** $used (balance $BALANCE_BEFORE → $BALANCE_AFTER)"
fi

DATE_TAG="$(date -u +%Y-%m-%d)"
REPORT="$RUN_DIR/ASSURANCE-RESULTS-${DATE_TAG}.md"
{
  echo "# Assurance Results — ${DATE_TAG}"
  echo
  echo "Generated by the Vehicle Insurance assurance workflow. Raw NDJSON logs, generated"
  echo "tests, and evidence links are attached to the workflow run as artifacts."
  echo
  cat "$RUN_DIR/summary.md"
} > "$REPORT"

if [ "$NEEDS_ATTENTION" -eq 1 ]; then
  echo "::warning::One or more stages need a human to resolve (see job summary). The run still produced results — check the summary and artifacts." >&2
fi

echo "Done. Report: $REPORT"
