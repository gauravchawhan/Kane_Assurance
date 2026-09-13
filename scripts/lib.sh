#!/usr/bin/env bash
# Shared helpers for the kane-cli assurance CI scripts.
# Source this file; do not execute it directly.

# kane_exit <ndjson-file>
# Reads the exit code out of the last {"type":"done",...} event instead of
# trusting $?. Assurance commands use exit codes as control flow:
# 0 = success · 2 = refusal · 3 = paused/resumable
kane_exit() {
  local file="$1"
  grep '"type":"done"' "$file" | tail -1 | jq -r '.exit_code // empty'
}

kane_field() {
  local file="$1" filter="$2"
  grep '"type":"done"' "$file" | tail -1 | jq -r "$filter // empty"
}

summary() {
  echo -e "$*" | tee -a "${RUN_DIR:-.}/summary.md" >/dev/null
  if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
    echo -e "$*" >> "$GITHUB_STEP_SUMMARY"
  fi
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || { echo "::error::required command '$1' not found on PATH" >&2; exit 1; }
}

best_effort_evidence_link() {
  local file="$1"
  grep -Eo 'https://test-manager\.[a-zA-Z0-9./_?=&%:-]+' "$file" 2>/dev/null | tail -1 || true
}

# Copy ONLY *.log files under a logs/ directory inside ~/.testmuai — never
# the rest of that tree (auth/session state) into a public artifact.
capture_kane_trace_logs() {
  local dest="${RUN_DIR:-run}/kane-trace-logs"
  mkdir -p "$dest"
  find "$HOME/.testmuai" -type f -path '*/logs/*.log' 2>/dev/null | while IFS= read -r f; do
    cp "$f" "$dest/$(echo "$f" | sed "s#^$HOME/##; s#/#__#g")" 2>/dev/null || true
  done
}

dump_stderr_to_summary() {
  local file="$1" label="$2"
  if [ -s "$file" ]; then
    summary ""
    summary "<details><summary>stderr — $label</summary>"
    summary ""
    summary '```'
    summary "$(cat "$file")"
    summary '```'
    summary "</details>"
  fi
}

# Merge the committed seed with any {{placeholders}} a designed test invented.
# Unknown names are filled from the closest seed value so authoring does not
# stall on a minted variable like {{x_first_name}}.
build_runtime_variables() {
  local testfile="$1"
  local seed="${VARIABLES_SEED:-kane-variables.seed.json}"
  local out=".testmuai/variables/runtime.json"
  mkdir -p .testmuai/variables

  local used
  used=$(grep -oE '\{\{[A-Za-z0-9_]+\}\}' "$testfile" 2>/dev/null | tr -d '{}' | sort -u || true)

  jq -n --slurpfile seed "$seed" --arg used "$used" '
    def pick($key; $seed):
      if $seed | has($key) then $seed[$key]
      elif ($key | test("email"; "i")) and ($seed | has("applicant_email")) then $seed.applicant_email
      elif ($key | test("phone"; "i")) and ($seed | has("applicant_phone")) then $seed.applicant_phone
      elif ($key | test("user"; "i")) and ($seed | has("applicant_username")) then $seed.applicant_username
      elif ($key | test("password|passwd|confirm"; "i")) and ($seed | has("applicant_password")) then $seed.applicant_password
      elif ($key | test("birth|dob"; "i")) and ($seed | has("date_of_birth")) then $seed.date_of_birth
      elif ($key | test("start.?date|future"; "i")) and ($seed | has("start_date")) then $seed.start_date
      elif ($key | test("manufactur"; "i")) and ($seed | has("date_of_manufacture")) then $seed.date_of_manufacture
      elif ($key | test("url|home|base"; "i")) and ($seed | has("home_url")) then $seed.home_url
      elif ($key | test("quote|wizard|app\\.php"; "i")) and ($seed | has("quote_url")) then $seed.quote_url
      elif ($key | test("make|brand"; "i")) and ($seed | has("vehicle_make")) then $seed.vehicle_make
      elif ($key | test("engine"; "i")) and ($seed | has("engine_performance")) then $seed.engine_performance
      elif ($key | test("seat"; "i")) and ($seed | has("number_of_seats")) then $seed.number_of_seats
      elif ($key | test("fuel"; "i")) and ($seed | has("fuel_type")) then $seed.fuel_type
      elif ($key | test("price|sum"; "i")) and ($seed | has("list_price")) then $seed.list_price
      elif ($key | test("mile"; "i")) and ($seed | has("annual_mileage")) then $seed.annual_mileage
      elif ($key | test("last.?name|surname"; "i")) and ($seed | has("last_name")) then $seed.last_name
      elif ($key | test("first.?name|name"; "i")) and ($seed | has("first_name")) then $seed.first_name
      elif ($key | test("zip|postcode"; "i")) and ($seed | has("zip_code")) then $seed.zip_code
      elif ($key | test("countr"; "i")) and ($seed | has("country")) then $seed.country
      elif ($key | test("occup"; "i")) and ($seed | has("occupation")) then $seed.occupation
      elif ($key | test("hobb"; "i")) and ($seed | has("hobby")) then $seed.hobby
      elif ($key | test("gold|silver|platinum|ultimate|plan|option"; "i")) and ($seed | has("price_option")) then $seed.price_option
      else {value: ($seed.first_name.value // "Alex")}
      end;
    ($seed[0] // {}) as $base
    | ($used | split("\n") | map(select(length > 0)) | unique) as $keys
    | reduce $keys[] as $k ($base; .[$k] = pick($k; $base))
  ' > "$out"
}
