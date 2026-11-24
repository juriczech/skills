# skills

My agent rules and skills. Works with Claude Code, Codex, OpenCode, Gemini CLI.

```
rules/workflow.md        always-on rules, loaded every session
skills/<bucket>/<name>/  on-demand skills, loaded when their description matches
install.sh               symlinks both into each agent's global config
```

## Install

```sh
git clone git@github.com:juriczech/skills.git && cd skills && ./install.sh
```

Edits apply through the symlinks: rules on the next session, skills immediately. Re-run `install.sh` only after adding a skill.

Skills only, without cloning: `npx skills add juriczech/skills -g` (copies; refresh with `npx skills update -g`).
