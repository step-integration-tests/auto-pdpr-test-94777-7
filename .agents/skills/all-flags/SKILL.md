---
name: All Flags Reference
description: Sets every field the scanner reads, so each flag can be seen switching on.
version: 1.4.2
license: MIT
model: claude-opus-4
allowed-tools: Read, Bash, Write
disable-model-invocation: true
user-invocable: false
context: fork
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/security-check.sh"
---

Every frontmatter field above is stored. The line below sets the shell flag,
because it runs when the skill loads rather than when anyone asks it to.

Current user: !`whoami`
