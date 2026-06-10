#!/usr/bin/env bash
# 使い方: gh auth login 済みの状態で  ./deploy.sh <github-username>
set -e
USER="${1:?GitHubユーザー名を指定してください: ./deploy.sh <username>}"
REPO="chusho-shindanshi-quiz"
gh repo create "$REPO" --public --source=. --remote=origin --push
gh api -X POST "repos/$USER/$REPO/pages" -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 || \
  gh api -X PUT "repos/$USER/$REPO/pages" -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 || true
echo ""
echo "公開URL（反映まで1〜2分）: https://$USER.github.io/$REPO/"
