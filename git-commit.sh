#!/usr/bin/env bash
set -euo pipefail

pause_on_exit=1

if [[ "${1:-}" == "--no-pause" ]]; then
  pause_on_exit=0
  shift
fi

pause_and_exit() {
  local exit_code="${1:-0}"
  echo
  if [[ "$pause_on_exit" -eq 1 ]]; then
    read -r -n 1 -s -p "Press any key to exit..." _
    echo
  fi
  exit "$exit_code"
}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: current directory is not inside a git repository."
  pause_and_exit 1
fi

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

msg="${1:-}"
if [[ -z "$msg" ]]; then
  now="$(date '+%Y-%m-%d %H:%M:%S')"
  msg="chore: update vault (${now})"
fi

git add -A

if git diff --cached --quiet; then
  echo "Nothing to commit."
  pause_and_exit 0
fi

if ! git commit -m "$msg"; then
  pause_and_exit 1
fi

echo "Commit created:"
echo "  message: $msg"
pause_and_exit 0
