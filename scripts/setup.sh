#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

REPOS=(
  "ksankaran/checkmate"
  "ksankaran/checkmate-ui"
  "ksankaran/playwright-http"
)

echo "==> Cloning repositories..."
for repo in "${REPOS[@]}"; do
  dir="${repo#*/}"
  if [ -d "$REPO_ROOT/$dir" ]; then
    echo "    $dir/ already exists — skipping"
  else
    echo "    Cloning $repo..."
    git clone "https://github.com/$repo.git" "$REPO_ROOT/$dir"
  fi
done

echo ""
echo "==> Setting up environment..."
if [ -f "$REPO_ROOT/.env" ]; then
  echo "    .env already exists — skipping"
else
  cp "$REPO_ROOT/.env.example" "$REPO_ROOT/.env"
  echo "    Created .env from .env.example"
fi

echo ""
echo "============================================"
echo "  Setup complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "  1. Edit .env and set your OPENAI_API_KEY"
echo "  2. Run: make dev"
echo "  3. Open: http://localhost:3001"
echo ""
