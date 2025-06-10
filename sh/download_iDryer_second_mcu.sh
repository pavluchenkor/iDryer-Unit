#!/usr/bin/env bash

REPO_URL="https://github.com/pavluchenkor/iDryer-Unit.git"
TARGET_DIR="iDryer_second_mcu"
TEMP_DIR=".temp_iDryer_clone"

# Проверка наличия git
command -v git >/dev/null 2>&1 || { echo >&2 "❌ Требуется git, но он не установлен."; exit 1; }

# Удаляем старые данные
rm -rf "$TEMP_DIR" "$TARGET_DIR"

# Клонируем репозиторий без содержимого
git clone --depth 1 --filter=blob:none --no-checkout "$REPO_URL" "$TEMP_DIR" || {
  echo "❌ Ошибка при клонировании репозитория"; exit 1;
}

cd "$TEMP_DIR" || exit 1

# Настройка sparse-checkout
git sparse-checkout init --cone
git sparse-checkout set "$TARGET_DIR"

# Checkout основной ветки
git checkout main || { echo "❌ Ошибка checkout"; exit 1; }

cd ..
mv "$TEMP_DIR/$TARGET_DIR" ./ || { echo "❌ Не удалось переместить папку"; exit 1; }

# Очистка
rm -rf "$TEMP_DIR"

echo "✅ Папка $TARGET_DIR успешно скачана в текущую директорию"
