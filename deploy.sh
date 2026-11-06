#!/usr/bin/env bash
# Проверяет новые коммиты в ветке и при необходимости пересобирает контейнер.
set -euo pipefail

cd "$(dirname "$0")"

# Защита от параллельных запусков (cron может вызвать скрипт повторно)
exec 9>.deploy.lock
flock -n 9 || exit 0

BRANCH="${DEPLOY_BRANCH:-main}"

git fetch origin "$BRANCH" --quiet

LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse "origin/$BRANCH")

if [ "$LOCAL" = "$REMOTE" ] && [ "${FORCE:-0}" != "1" ]; then
    exit 0
fi

echo "[$(date '+%F %T')] Обновление ветки $BRANCH: ${LOCAL:0:7} -> ${REMOTE:0:7}"

git checkout -q "$BRANCH"
git reset --hard "origin/$BRANCH"

docker compose up -d --build
docker image prune -f > /dev/null

echo "[$(date '+%F %T')] Развёртывание завершено"