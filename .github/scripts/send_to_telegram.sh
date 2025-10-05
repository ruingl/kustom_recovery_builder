#!/bin/bash
set -e

DEVICE="$1"
BRANCH="$2"
BUILD_DATE="$3"
COMMIT_ID="$4"
RELEASE_URL="$5"
DEVICE_TREE="$6"
CHAT_ID="$7"
TOKEN="$8"

send_file() {
  local FILE_PATH="$1"
  local CAPTION="$2"

  if [[ ! -f "$FILE_PATH" ]]; then
    echo "⚠️ Skipping: $FILE_PATH (not found)"
    return 0
  fi

  echo "📤 Uploading: $FILE_PATH"
  curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendDocument" \
    -F chat_id="${CHAT_ID}" \
    -F document=@"${FILE_PATH}" \
    -F caption="${CAPTION}" \
    -F parse_mode="MarkdownV2"
}

# === Send massage ===
text=$(
  cat << EOF
🚀 *Unofficial Custom Recovery Build Released*
📱 *Device*: \`${DEVICE}\`
🌿 *Branch*: \`${BRANCH}\`
📅 *Build Date*: \`${BUILD_DATE}\`
🔗 [View Release on GitHub](${RELEASE_URL})
📝 *Commit*: [${COMMIT_ID}](${DEVICE_TREE}/commit/${COMMIT_ID})
EOF
)

curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" \
  -d chat_id="$CHAT_ID" \
  -d text="$text" \
  -d parse_mode="MarkdownV2"
