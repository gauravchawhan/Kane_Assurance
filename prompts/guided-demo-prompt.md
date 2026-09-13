# Guided demo prompt

Use this when driving the lifecycle interactively (e.g. from Cursor with
the kane-cli skill installed). It stops at both human checkpoints — that
pause **is** the pitch.

---

> Run the kane-cli assurance lifecycle end to end in this repository against
> `sources/feature-spec.md`, targeting the Tricentis Vehicle Insurance
> sample at https://sampleapp.tricentis.com/101/#.
>
> Follow the documented journey in order and stop at both human checkpoints:
>
> 1. `context ingest` the spec with `--mode agent` so it lands and extracts in
>    one flow.
> 2. Before I approve anything, enumerate every unreviewed use-case with
>    `context list --json --inferred` and show me each one's title,
>    description, acceptance claims, **and the cited source quote with its
>    line anchor**. Then ask me for my review verdicts — do not promote
>    anything to trusted on your own.
> 3. Once I approve, `design tests` for the use-case I pick, with `--max 3`.
>    Present the acceptance criteria, the scenario, the generated test, **and
>    every gap and warning** — I want the gaps and warnings called out
>    explicitly, not summarised away.
> 4. Ask me for verdicts on the design output, then land them.
> 5. Author the approved test with `testmd run --agent --headless`, supplying
>    values from `kane-variables.seed.json` for any `{{variables}}` the
>    design left open.
> 6. Finish with `cover gaps` and explain the designed × proven numbers —
>    specifically, tell me what the denominator is and what is still owed.
>
> Track credits as you go and give me the total at the end. Never run two
> store-mutating commands at once. Never write `*_test.md` files by hand.

---

For the fully automated, no-agent-in-the-loop version of this same lifecycle,
see `.github/workflows/kane-cli-assurance.yml` and `scripts/run-assurance.sh`.
