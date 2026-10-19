#!/usr/bin/env bash
# deploy_site.sh — push portfolio ke GitHub dan nyalakan Pages.
#
# Prasyarat: repo KOSONG sudah dibuat di github.com (tanpa README, tanpa .gitignore).
# Pemakaian:
#   ./deploy_site.sh                # default: kaican77/portfolio
#   ./deploy_site.sh user repo      # repo lain
set -euo pipefail

USER_GH="${1:-kaican77}"
REPO="${2:-portfolio}"
KEY="$HOME/.ssh/github_josjis"
DIR="$HOME/career/site"

export GIT_SSH_COMMAND="ssh -i $KEY -o IdentitiesOnly=yes"

cd "$DIR"

if [ ! -d .git ]; then
  git init -q
  git config user.name  "Vladimir Isanovski"
  git config user.email "isanovski@users.noreply.github.com"
fi

# pastikan branch main
git branch -M main 2>/dev/null || true

# remote
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "git@github.com:$USER_GH/$REPO.git"
else
  git remote add origin "git@github.com:$USER_GH/$REPO.git"
fi

# commit kalau ada perubahan
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -q -m "Update portfolio"
fi

echo "→ push ke github.com:$USER_GH/$REPO"
git push -u origin main

cat <<EOF

✓ Push selesai.

Langkah terakhir (manual, 2 klik):
  1. Buka https://github.com/$USER_GH/$REPO/settings/pages
  2. Source: Deploy from a branch
     Branch: main   /   Folder: / (root)
  3. Save, tunggu ~40 detik

URL publik:
  https://$USER_GH.github.io/$REPO/
EOF
