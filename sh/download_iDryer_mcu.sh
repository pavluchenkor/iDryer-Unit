#!/usr/bin/env bash

REPO_URL="https://github.com/pavluchenkor/iDryer-Unit.git"
TARGET_DIR="iDryer_mcu"
TEMP_DIR=".temp_iDryer_clone"

# Checking git availability
command -v git >/dev/null 2>&1 || { echo >&2 "❌ Requires git, but it is not installed."; exit 1; }

# Delete old data
rm -rf "$TEMP_DIR" "$TARGET_DIR"

# Clone a repository without content
git clone --depth 1 --filter=blob:none --no-checkout "$REPO_URL" "$TEMP_DIR" || {
  echo "❌ Error when cloning a repository"; exit 1;
}

cd "$TEMP_DIR" || exit 1

# Configuring sparse-checkout
git sparse-checkout init --cone
git sparse-checkout set "$TARGET_DIR"

# Checkout основной ветки
git checkout main || { echo "❌ Error checkout"; exit 1; }

cd ..
mv "$TEMP_DIR/$TARGET_DIR" ./ || { echo "❌ Failed to move folder"; exit 1; }

# Erasing
rm -rf "$TEMP_DIR"

echo "✅ The $TARGET_DIR folder has been successfully downloaded to the current directory"
