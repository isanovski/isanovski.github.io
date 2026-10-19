#!/usr/bin/env bash
# switch_github.sh — ganti akun GitHub untuk repo portfolio tanpa mengganggu akun lama.
#
# Pemakaian:
#   ./switch_github.sh <username-github-baru>
#
# Contoh:
#   ./switch_github.sh vladimir-isanovski
#
# Yang dilakukan:
#   1. set remote ke akun baru lewat SSH alias github.com-isanovski
#   2. set identitas commit ke nama publik + noreply email
#   3. tes autentikasi (harus muncul "Hi <username>!")
#   4. push
set -euo pipefail

USER_GH="${1:-}"
if [ -z "$USER_GH" ]; then
  echo "pakai: ./switch_github.sh <username-github-baru>"
  exit 1
fi

REPO="${2:-portfolio}"
KEY="$HOME/.ssh/github_isanovski"
DIR="$HOME/career/site"
ALIAS="github.com-isanovski"

cd "$DIR"

export GIT_SSH_COMMAND="ssh -i $KEY -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new"

echo "→ remote: $ALIAS:$USER_GH/$REPO"
git remote set-url origin "git@$ALIAS:$USER_GH/$REPO.git"

echo "→ identitas commit"
git config user.name  "Vladimir Isanovski"
git config user.email "isanovski@users.noreply.github.com"

echo "→ tes autentikasi"
AUTH="$(ssh -T -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new -i "$KEY" "$ALIAS" 2>&1 || true)"
echo "  $AUTH"

if ! echo "$AUTH" | grep -q "successfully authenticated"; then
  cat <<'EOF'

✗ Autentikasi gagal.

Kemungkinan penyebab:
  1. Public key belum ditambahkan ke akun baru
     → https://github.com/settings/keys  → New SSH key
     → paste isi: ~/.ssh/github_isanovski.pub

  2. Repo belum dibuat
     → https://github.com/new  → nama: portfolio → Public → Create
       (jangan centang README / .gitignore / license)

  3. Username salah
EOF
  exit 1
fi

echo "→ push"
git branch -M main
git push -u origin main

cat <<EOF

✓ Selesai.

Langkah terakhir (manual):
  https://github.com/$USER_GH/$REPO/settings/pages
  Source: Deploy from a branch → main → / (root) → Save

URL publik:
  https://$USER_GH.github.io/$REPO/
EOF
