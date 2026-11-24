---
name: review
description: Review code changes in my style, optionally as pending GitHub PR comments. Use when I ask to review a branch, a PR, or work in progress.
---

Run the `code-review` skill with the overrides below. If `code-review` is not among your available skills, stop and tell me to install it: `npx skills add mattpocock/skills -g -s code-review`.

## Overrides

- Fixed point: a PR → its base branch (`gh pr view <n> --json baseRefName`). Nothing given → the merge-base with the default branch.
- Number the findings in the final report.
- Add a third axis, **Design**, as a parallel sub-agent beside Standards and Spec, reported under `## Design`.

## Design axis

Standards and Spec read the diff; Design reads the diff against the **existing codebase**. Search beyond the changed files. Brief for the sub-agent:

- **Reuse**: new code that duplicates knowledge already in the codebase, especially the same logic built separately for mobile and for desktop/web. DRY in its original sense: one source of truth per piece of knowledge, not per code shape. Point to the existing code and say how to share it: reuse as is, extract to a shared package, or generalise the existing one.
- **Simplification**: redundant code, and logic that a simpler shape expresses with the same behaviour. Show the simpler shape.
- **Boundaries**: code in the wrong package or layer, dependencies pointing the wrong way, a module taking on a responsibility that belongs elsewhere. Name where it belongs.

Each finding: `file:line`, the problem, the concrete fix.

## Pending PR comments

After the report, when reviewing a PR, ask which findings to post. Post only the ones I pick, as one **pending** review: visible only to me until I submit it on GitHub.

```sh
gh api repos/{owner}/{repo}/pulls/<n>/reviews --method POST --input review.json
```

`review.json`: `{"body": "...", "comments": [{"path": "...", "line": 42, "side": "RIGHT", "body": "..."}]}`. Leave out `event`: that is what keeps the review pending.

- Inline comments attach only to lines in the PR diff; findings elsewhere go in `body`.
- Write each comment as I would write it to the author: short, direct, a suggestion. Use a ```` ```suggestion ```` block when the fix is a direct replacement of the commented lines.
- GitHub allows one pending review per PR. If one already exists, tell me and stop.
- Finish with the PR URL.
