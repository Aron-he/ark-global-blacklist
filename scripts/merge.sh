#!/usr/bin/env bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OFFICIAL_URL="https://cdn2.arkdedicated.com/asa/BanList.txt"
MERGED_FILE="$ROOT_DIR/build/blacklist.txt"
FILTERED_FILE="$ROOT_DIR/build/blacklist.without-whitelist.txt"
WHITELIST_FILE="$ROOT_DIR/custom/whitelist.txt"

echo "[1/4] Fetch official blacklist"
curl -fsSL "$OFFICIAL_URL" \
  -o "$ROOT_DIR/upstream/official.txt"

echo "[2/4] Concatenate blacklist (safe newline)"
cat "$ROOT_DIR/upstream/official.txt" > "$MERGED_FILE"
echo "" >> "$MERGED_FILE"
cat "$ROOT_DIR/custom/blacklist.txt" >> "$MERGED_FILE"

echo "[3/4] Generate whitelist-filtered blacklist"
if [ -f "$WHITELIST_FILE" ]; then
  awk -F',' '
    FNR == NR {
      gsub(/\r$/, "", $0)
      if ($0 == "" || $0 ~ /^[[:space:]]*#/) next
      id = $1
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", id)
      if (id != "") whitelist[id] = 1
      next
    }
    {
      line = $0
      gsub(/\r$/, "", line)
      id = line
      sub(/,.*/, "", id)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", id)
      if (id in whitelist) next
      print $0
    }
  ' "$WHITELIST_FILE" "$MERGED_FILE" > "$FILTERED_FILE"
else
  cp "$MERGED_FILE" "$FILTERED_FILE"
fi

echo "[4/4] Done"
echo "Official lines: $(wc -l < "$ROOT_DIR/upstream/official.txt")"
echo "Custom lines:   $(wc -l < "$ROOT_DIR/custom/blacklist.txt")"
echo "Final lines:    $(wc -l < "$MERGED_FILE")"
echo "Filtered lines: $(wc -l < "$FILTERED_FILE")"
