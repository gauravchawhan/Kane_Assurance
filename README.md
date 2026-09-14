# Kane CLI Assurance — Tricentis Vehicle Insurance

Independent assurance suite for the public
[Vehicle Insurance Application](https://sampleapp.tricentis.com/101/#)
(Version 1.0.1). There is **no application login**. Quotes are taken from the
home-page catalogue through the wizard:

**Automobile / Truck / Motorcycle / Camper** → Enter Vehicle Data → Enter
Insurant Data → Enter Product Data → Select Price Option (Silver / Gold /
Platinum / Ultimate) → Send Quote.

Requirements live in [`bfsFile.md`](./bfsFile.md) (labels and validation
taken from the live sample app). Tests are **designed by Kane CLI**, not
hand-written.

```
Discover → Extract → Review → Design tests → Author → Execute
  → Evidence → Coverage (proven vs owed) → Maintain
```

| Kane CLI command | Role |
|---|---|
| `context ingest` / `extract` / `review` | Snapshot requirements, extract use-cases, promote them |
| `design tests` / `context review` | Acceptance criteria, scenarios, `*_test.md` files |
| `testmd run` | Author (first browser run) a single designed test |
| `testrun run` | Batch-execute authored tests; one sealed evidence pack |
| `cover` / `cover gaps` | Designed vs proven coverage per use case |
| `evidence serve` / `validate` | View or check a `.evidence` pack |
| `maintain reconcile` | Re-align the suite when requirements change |

## Business use cases

| Use case | Designed | Tests | Status |
|---|---|---|---|
| Start an insurance quote | 100% | 2 | designed, not yet proven |
| Provide vehicle details for a quote | 63% | 4 | designed, not yet proven |
| Provide insurant details for a quote | 100% | 3 | designed, not yet proven |
| Choose coverage options for a quote | 100% | 3 | designed, not yet proven |
| Choose a quote plan | 67% | 3 | designed, not yet proven |
| Send a quote by email | 63% | 3 | designed, not yet proven |

**Overall: 64/80 ACs have a verifying test (80% designed). Proven stays empty
until tests are authored in a real browser.**

Run `kane-cli cover gaps` locally for live numbers (needs the local `.context/`
store from ingest/design).

## Repo layout

```
bfsFile.md                         Requirement source for this suite
sources/feature-spec.md            Smaller spec used by the lifecycle workflow
sources/feature-spec-v2.md         Changed spec for a maintain-reconcile demo
kane-variables.seed.json           Public sample values for {{placeholders}}
.testmuai/context.md               Guidance for designed tests
.testmuai/tests/*_test.md          18 designed, requirement-linked tests
.testmuai/variables/               Runtime JSON (gitignored; CI rebuilds it)
.testmuai/evidence/                Sealed packs (gitignored; CI artifacts)
.context/                          Local requirement graph (gitignored)
.github/workflows/assurance.yml    Author + testrun + cover + evidence
.github/workflows/kane-cli-assurance.yml   Ingest → design → author lifecycle
scripts/run-assurance.sh           Lifecycle driver used by CI
scripts/run-reconcile.sh           Maintain demo against feature-spec-v2.md
prompts/                           Optional demo prompts
```

## Prerequisites

- Node.js 20+ and npm
- Google Chrome (desktop target)
- A TestMu AI / LambdaTest account with Kane CLI access
- Kane CLI **0.8.4 or newer** (this repo pins **0.8.12** in CI). Before 0.8.4,
  `testrun` refuses never-authored tests (`missing_meta`).

```bash
npm install -g @testmuai/kane-cli@0.8.12
kane-cli --version
kane-cli install skill    # optional; agent skill for local assistant use
```

## Authenticate and point at the sample app

```bash
kane-cli login --username "<your-username>" --access-key "<your-access-key>"
kane-cli whoami                          # must say Authenticated
kane-cli config set-target desktop       # not emulator/simulator
kane-cli config set-url 'https://sampleapp.tricentis.com/101/#'
```

Always quote the URL. An unquoted `#` is a shell comment.

## Test data

[`kane-variables.seed.json`](./kane-variables.seed.json) holds public sample
values (make, dates, email, password for Send Quote, and so on). Kane loads
every JSON file under `.testmuai/variables/` automatically.

`--variables-file` is valid on `kane-cli run` and `kane-cli testmd run` only.
**`testrun run` does not accept `--variables-file`.** For a batch run, write
the seed to `.testmuai/variables/runtime.json` first (CI does this).

## Local run

Designed `*_test.md` files have no recording. **Author each test at least
once** before a batch `testrun`, or `testrun` exits `2` (invalid plan) and
nothing executes.

```bash
# From this directory (the repo root, not a parent folder)
cd /path/to/Kane_Assurance

# One test (author)
kane-cli testmd run \
  .testmuai/tests/verify-the-public-catalogue-shows-the-four-quoteable_test.md \
  --agent --headless \
  --variables-file .testmuai/variables/runtime.json

# Build runtime variables from the seed if the file is missing
mkdir -p .testmuai/variables
cp kane-variables.seed.json .testmuai/variables/runtime.json

# All tests: author first, then one sealed suite
# Pass paths explicitly — a bare testrun walk skips hidden .testmuai/
for f in .testmuai/tests/*_test.md; do
  kane-cli testmd run "$f" --agent --headless \
    --variables-file .testmuai/variables/runtime.json
done

kane-cli testrun run .testmuai/tests/*_test.md \
  --headless --on-failure continue --dry-run     # plan only; exit 0 = valid

kane-cli testrun run .testmuai/tests/*_test.md \
  --headless --on-failure continue

kane-cli cover
kane-cli cover gaps
```

Optional local lifecycle (ingest + design + author from the small spec):

```bash
bash scripts/run-assurance.sh
# optional requirements-change demo:
bash scripts/run-reconcile.sh
```

View a sealed pack:

```bash
kane-cli evidence serve .testmuai/evidence/<pack>.evidence
kane-cli evidence validate .testmuai/evidence/<pack>.evidence
```

### testrun exit codes

| Code | Meaning |
|---|---|
| `0` | Every member passed |
| `1` | At least one member failed or broke (results still in evidence) |
| `2` | Usage error, invalid plan, or auth — **nothing ran** |
| `3` | Cancelled |

## GitHub Actions

Repo: [gauravchawhan/Kane_Assurance](https://github.com/gauravchawhan/Kane_Assurance).

### 1. Secrets

**Settings → Secrets and variables → Actions.** Set one username/key pair
(Dashboard → Credentials):

| Secret | Required | Purpose |
|---|---|---|
| `LT_USERNAME` | yes (or an alias) | Kane / TestMu username |
| `LT_ACCESS_KEY` | yes (or an alias) | Access key |
| `KANE_USERNAME` | alias | Used if `LT_USERNAME` is empty |
| `KANE_ACCESS_KEY` | alias | Used if `LT_ACCESS_KEY` is empty |
| `KANE_CLI_USERNAME` | alias | Same |
| `KANE_CLI_ACCESS_KEY` | alias | Same |

### 2. Vehicle Insurance Assurance Suite

Workflow file: `.github/workflows/assurance.yml`.

Runs committed tests under `.testmuai/tests/`:

1. Login, desktop target, sample-app URL, Chrome, Kane CLI 0.8.12
2. Write `.testmuai/variables/runtime.json` from `kane-variables.seed.json`
3. **`testmd run --headless --agent`** for each selected `*_test.md`
4. **`testrun run --dry-run`**, then **`testrun run`** on the same paths
5. `cover` / `cover gaps`
6. Upload artifacts: evidence packs, `testrun.log`, `authoring_links.tsv`,
   coverage report

**Triggers:** push to `main` when tests, this workflow, or the variables seed
change; or **Actions → Vehicle Insurance Assurance Suite → Run workflow**.

**Input `max_tests_to_run`:** `0` (default) = all 18 tests. Set to `1` for a
smoke check. Authoring all 18 in CI can take several hours (job timeout is
360 minutes).

Failed tests are recorded as results (`::warning::`). The job fails on setup
problems (missing secrets, invalid testrun plan / exit `2`).

### 3. Kane CLI Assurance — Vehicle Insurance

Workflow file: `.github/workflows/kane-cli-assurance.yml`.

Full lifecycle against `sources/feature-spec.md` via
`scripts/run-assurance.sh` (ingest → review → design → author → cover).

**Triggers:** `workflow_dispatch`; push to `main` when `sources/**`,
`bfsFile.md`, or this workflow change; weekly Monday 03:00 UTC.

**Input `run_reconcile`:** when true, also runs
`scripts/run-reconcile.sh` against `sources/feature-spec-v2.md`.

### Artifacts

| Artifact | Contents |
|---|---|
| `evidence-packs-<run>` | `.evidence` packs, testrun logs, authoring links |
| `coverage-report-<run>` | `cover` / `cover gaps` text |
| `kane-cli-assurance-evidence-<run>` | `run/**`, generated tests, evidence (lifecycle job) |

Download a pack and open it locally with `kane-cli evidence serve <file>`.

## Keeping the suite current

Do not edit `*_test.md` by hand. Reconcile from the requirement file:

```bash
kane-cli maintain reconcile --from ./bfsFile.md --source-id bfsfile --mode agent
```

Then review derived nodes, design any new tests with Kane CLI, and author
them with `testmd run` before the next `testrun`.

## Troubleshooting

| Symptom | Likely cause | What to do |
|---|---|---|
| `unknown option '--variables-file'` | Flag passed to `testrun` | Use it only on `testmd run` / `run`. Put JSON under `.testmuai/variables/` |
| testrun exit `2` in seconds, no evidence | Empty plan, unauthored tests, or bad flags | Pass `.testmuai/tests/*_test.md` explicitly; author with `testmd run` first; `--dry-run` |
| testrun finds 0 tests | Recursive walk skips hidden `.testmuai/` | Always pass paths or `find .testmuai/tests -name '*_test.md'` |
| Job fails on login | Missing Actions secrets | Set `LT_USERNAME` and `LT_ACCESS_KEY` |
| Chrome / v16-runner errors | No Chrome or wrong target | `config set-target desktop`; install Chrome; set `KANE_CLI_CHROME_PATH` |
| Coverage empty in CI | `.context/` is gitignored | Proven numbers need a local graph or a lifecycle ingest on that runner |
| Start URL ignored | Unquoted `#` in the shell | `kane-cli config set-url 'https://sampleapp.tricentis.com/101/#'` |
