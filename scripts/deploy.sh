#!/usr/bin/env bash
# One-command deploy: commit + push + IndexNow notify.
# Usage: scripts/deploy.sh "commit message"   (or just: scripts/deploy.sh)
set -euo pipefail
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

msg="${1:-Site update $(date '+%Y-%m-%d %H:%M')}"
git add -A
if git diff --cached --quiet; then
  echo "deploy: nothing to commit"
else
  git commit -m "$msg"
fi
git push

# Notify Bing/IndexNow of changed URLs (no-op when HTML unchanged)
"$(dirname "$0")/indexnow.sh" push || echo "deploy: indexnow skipped/failed (non-fatal)"
