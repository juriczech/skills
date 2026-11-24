# How I work with agents

## Review and staging

I review agent changes in the Fork git client: I stage what I approve and iterate with the agent on the rest. The index is mine.

- Leave staged changes exactly as I staged them; unstage only on my explicit request.
- Stage, commit, and push only after I approve everything by saying "commit it" or "create a PR".

## Pull requests

Act on a pull request (create, publish, convert, mark ready, update, merge, close) only on my explicit request for that exact action.

## Verification

Typecheck, tests, lint, format, and build run in two cases: I ask for them, or you are committing. Scope them to the affected packages and run each once.

## Attribution

Commit messages and PR descriptions carry no AI attribution: no `Co-Authored-By` trailer, no "Generated with" line.

## Repo conventions

A repo's own documented conventions (`AGENTS.md`, `CONTRIBUTING.md`, commitlint config, PR template) override the preferences here.

## Reporting

Extremely concise. Sacrifice grammar for concision.
