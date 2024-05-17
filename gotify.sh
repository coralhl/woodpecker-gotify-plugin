#!/bin/sh

TRIMMED_URL=$(echo "${PLUGIN_GOTIFY_URL}" | sed 's:/*$::')

PRIORITY="${PLUGIN_PRIORITY:-0}"
if [[ ! "${priority}" =~ ^[1-9][0-9]*$ ]]; then
    PRIORITY=5
fi
PRIORITY=$((PRIORITY))

DEFAULT_TITLE="${CI_REPO_NAME}"
DEFAULT_MESSAGE="Build ${CI_REPO} (${CI_COMMIT_MESSAGE})"

MESSAGE="${PLUGIN_MESSAGE:-${DEFAULT_MESSAGE}}"
ESCAPED_MESSAGE=$(echo "${MESSAGE}" | sed ':a;N;$!ba;s/\n/\\n/g')
ESCAPED_TITLE=$(echo "${PLUGIN_TITLE:-${DEFAULT_TITLE}}" | sed ':a;N;$!ba;s/\n/\\n/g')

echo "${ESCAPED_TITLE}"
echo "${ESCAPED_MESSAGE}"

curl \
    -q -s \
    -H "Content-Type: application/json" \
    -H "X-Gotify-Key: ${PLUGIN_TOKEN}" \
    -d '{
        "title": "'"${ESCAPED_TITLE}"'",
        "message": "'"${ESCAPED_MESSAGE}"'",
        "priority": '${PRIORITY}'
    }' \
    "${TRIMMED_URL}/message"
