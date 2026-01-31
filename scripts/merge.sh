#!/usr/bin/env bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OFFICIAL_URL="https://cdn2.arkdedicated.com/asa/BanList.txt"

echo "[1/3] Fetch official blacklist"
curl -fsSL "$OFFICIAL_URL" \
  -o "$ROOT_DIR/upstream/official.txt"

echo "[2/3] Concatenate blacklist (safe newline)"

# 先写官方列表
cat "$ROOT_DIR/upstream/official.txt" > "$ROOT_DIR/build/blacklist.txt"

# 强制补一个换行（避免官方文件末尾没 \n）
echo "" >> "$ROOT_DIR/build/blacklist.txt"

# 再追加自定义列表
cat "$ROOT_DIR/custom/blacklist.txt" >> "$ROOT_DIR/build/blacklist.txt"

echo "[3/3] Done"
echo "Official lines: $(wc -l < "$ROOT_DIR/upstream/official.txt")"
echo "Custom lines:   $(wc -l < "$ROOT_DIR/custom/blacklist.txt")"
echo "Final lines:    $(wc -l < "$ROOT_DIR/build/blacklist.txt")"
