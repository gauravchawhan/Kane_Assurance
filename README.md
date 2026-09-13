# Kane CLI Assurance — Tricentis Vehicle Insurance

Independent assurance run against the public
[Vehicle Insurance Application](https://sampleapp.tricentis.com/101/#)
(Version 1.0.1), produced with kane-cli following the same flow as
[CLI-Assurance-BFSI](https://github.com/ishanaggarwal04/CLI-Assurance-BFSI),
[kaneCLIassurance](https://github.com/prashant-sharmaaa/kaneCLIassurance), and
[N_KaneCLI_Assurance](https://github.com/naveentestmuai-source/N_KaneCLI_Assurance/actions/runs/34610878020):

> Discover → Extract → Review → Design Tests → Execute → Collect Evidence → Generate Assurance Results → Identify Proven vs Owed

No login is required. Every acceptance criterion was extracted from
[`bfsFile.md`](./bfsFile.md) against the live form’s published labels and
validation rules.

## Business use cases

| Use case | Designed | Tests | Status |
|---|---|---|---|
| Start an insurance quote | 100% | 2 | designed, not yet proven |
| Provide vehicle details for a quote | 63% | 4 | designed, not yet proven |
| Provide insurant details for a quote | 100% | 3 | designed, not yet proven |
| Choose coverage options for a quote | 100% | 3 | designed, not yet proven |
| Choose a quote plan | 67% | 3 | designed, not yet proven |
| Send a quote by email | 63% | 3 | designed, not yet proven |

**Overall: 64/80 ACs have a verifying test (80% designed). Proven is empty until the first authored run.**

Run `kane-cli cover gaps` for live numbers.

## Repo layout

```
bfsFile.md                      # requirement doc this suite was designed from
sources/feature-spec.md         # 4-requirement CI slice
sources/feature-spec-v2.md      # changed spec for maintain reconcile
.testmuai/tests/*_test.md       # 18 designed, requirement-linked tests
.context/                       # local requirement graph (gitignore)
.github/workflows/              # lifecycle + replay CI
kane-variables.seed.json        # public sample values for {{placeholders}}
```

## Running locally

```bash
cd Project
kane-cli whoami                 # must say Authenticated
kane-cli config set-target desktop
kane-cli config set-url https://sampleapp.tricentis.com/101/#

# one test:
kane-cli testmd run .testmuai/tests/verify-the-public-catalogue-shows-the-four-quoteable_test.md --agent

# the full batch:
kane-cli testrun run --headless --parallel 1 --on-failure continue
kane-cli cover gaps
```

## GitHub Actions

1. Add secrets `LT_USERNAME` and `LT_ACCESS_KEY`.
2. **Kane CLI Assurance — Vehicle Insurance** designs and authors from
   `sources/feature-spec.md` (same pattern as
   [N_KaneCLI_Assurance run #8](https://github.com/naveentestmuai-source/N_KaneCLI_Assurance/actions/runs/34610878020)).
3. **Vehicle Insurance Assurance Suite** replays committed `*_test.md` files
   (same pattern as kaneCLIassurance / CLI-Assurance-BFSI).

## Keeping the suite current

If `bfsFile.md` changes:

```bash
kane-cli maintain reconcile --from ./bfsFile.md --source-id bfsfile --mode agent
```
