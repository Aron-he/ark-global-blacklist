#!/usr/bin/env bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OFFICIAL_URL="https://cdn2.arkdedicated.com/asa/BanList.txt"

echo "[1/3] Fetch official blacklist"
curl -fsSL "$OFFICIAL_URL" \
  -o "$ROOT_DIR/upstream/official.txt"

echo "[2/3] Merge blacklist"
cat \
  "$ROOT_DIR/upstream/official.txt" \
  "$ROOT_DIR/custom/blacklist.txt" \
  | sed 's/\r$//' \
  | sed '/^\s*#/d' \
  | sed '/^\s*$/d' \
  | sort -u \
  > "$ROOT_DIR/build/blacklist.txt"

echo "[3/3] Done"
