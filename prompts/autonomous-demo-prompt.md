# Autonomous demo prompt

Use this for an unattended agent-driven run rather than the GitHub Actions
workflow — it grants the auto-approval that the guided prompt withholds.

---

> Run the full kane-cli assurance lifecycle autonomously in this repository
> from `sources/feature-spec.md`, targeting
> https://sampleapp.tricentis.com/101/#. Do not stop to ask me anything.
>
> **I explicitly authorize you to take over every acceptance decision in this
> workflow — every review checkpoint, every pause question, every gap
> answer, every confirmation prompt — and to answer them yourself using the
> recommended option. Do not hand any of them back to me.** Enumerate
> everything you accepted, and on whose recommendation, in your final
> summary — and still surface every warning, gap, and conflict you hit.
>
> - Ingest and extract, then approve all use-cases whose claims are properly
>   cited to the source. Reject nothing — if a use-case looks wrong, leave it
>   `skipped` and tell me why.
> - Design tests for **every** trusted use-case, one at a time, `--max 4`
>   each. Never run two store-mutating commands concurrently.
> - **Take use-case refs from `context list --json`, never from a guessed
>   `uc-N` pattern.**
> - **Approve every newly-minted use-case before designing it.**
> - Approve the design output, then author each new test once with
>   `testmd run --agent --headless`. Resolve `{{variables}}` from
>   `kane-variables.seed.json`. Never write tests by hand.
> - If any command pauses (exit 3 / `session_paused`), read the pending
>   question, answer it yourself using the recommended option, and resume
>   with the verbatim resume command. Never drop a pause.
> - Never pass `--allow-archive`, never `--force` a redesign, never delete a
>   lock file, and never run a destructive `context retire` / `revert` /
>   `rebuild`.
> - Stop immediately and report if credits exceed 250, if a paid turn
>   errors, or if a citation fails verification (`CITE_UNVERIFIED`).
> - Then run `cover gaps --mode agent` and record the designed × proven
>   numbers.
> - **If I have given you a changed version of the spec**
>   (`sources/feature-spec-v2.md`), finish by running `maintain reconcile
>   --from sources/feature-spec-v2.md --source-id feature-spec --mode agent`.
>   Do **not** `context ingest` the new file first. Expect it to end at
>   exit 3 with an archive decision stored for a human: report the plan path
>   and stop there. Never pass `--apply` or `--allow-archive` yourself. Then
>   re-run `cover gaps` and tell me how the proven number moved.
> - Finish by writing a dated run report to `ASSURANCE-RESULTS-<date>.md`
>   containing: what was extracted, what you approved and why, every gap and
>   warning, the test results with evidence links, the final designed ×
>   proven numbers, and the total credits.

---

For the version of this same idea that runs on a schedule with no agent
in the loop at all, see `.github/workflows/kane-cli-assurance.yml`.
