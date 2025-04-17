#!/bin/bash

# Script to check for missing localizations in Flutter project
# Usage: ./check_localization.sh [path_to_lib_folder]

LIB_PATH=${1:-"lib"}
LOCALIZATION_PATH="$LIB_PATH/l10n"
EN_FILE="$LOCALIZATION_PATH/app_en.arb"
FR_FILE="$LOCALIZATION_PATH/app_fr.arb"

if [ ! -f "$EN_FILE" ]; then
  echo "Error: English localization file not found at $EN_FILE"
  exit 1
fi

if [ ! -f "$FR_FILE" ]; then
  echo "Error: French localization file not found at $FR_FILE"
  exit 1
fi

echo "Checking for localization string references in Dart files..."

# Extract all localization string references from Dart files
# Format is l10n.stringName or LocalizationService.of(context).stringName
dart_locs=$(grep -r "l10n\." --include="*.dart" $LIB_PATH | sed -E 's/.*l10n\.([a-zA-Z0-9_]+).*/\1/g' | sort | uniq)
dart_locs+=$(grep -r "LocalizationService.of(context)\." --include="*.dart" $LIB_PATH | sed -E 's/.*LocalizationService\.of\(context\)\.([a-zA-Z0-9_]+).*/\1/g' | sort | uniq)

# Extract all defined localization keys from English ARB file
en_keys=$(grep -o '"[^"]*":' $EN_FILE | sed -E 's/"([^"]*)":$/\1/' | grep -v "^@" | sort | uniq)

# Extract all defined localization keys from French ARB file
fr_keys=$(grep -o '"[^"]*":' $FR_FILE | sed -E 's/"([^"]*)":$/\1/' | grep -v "^@" | sort | uniq)

echo ""
echo "=== MISSING LOCALIZATIONS ==="
echo ""

# Check for references in Dart that are missing in English file
echo "Keys referenced in Dart files but missing in English localization:"
missing_in_en=0
for key in $dart_locs; do
  if ! echo "$en_keys" | grep -q "^$key$"; then
    echo "  - $key"
    missing_in_en=1
  fi
done
if [ $missing_in_en -eq 0 ]; then
  echo "  None"
fi

echo ""

# Check for references in Dart that are missing in French file
echo "Keys referenced in Dart files but missing in French localization:"
missing_in_fr=0
for key in $dart_locs; do
  if ! echo "$fr_keys" | grep -q "^$key$"; then
    echo "  - $key"
    missing_in_fr=1
  fi
done
if [ $missing_in_fr -eq 0 ]; then
  echo "  None"
fi

echo ""

# Check for keys in English file but not in French file
echo "Keys in English file but missing in French file:"
en_fr_diff=0
for key in $en_keys; do
  if ! echo "$fr_keys" | grep -q "^$key$"; then
    echo "  - $key"
    en_fr_diff=1
  fi
done
if [ $en_fr_diff -eq 0 ]; then
  echo "  None"
fi

echo ""
if [ $missing_in_en -eq 0 ] && [ $missing_in_fr -eq 0 ] && [ $en_fr_diff -eq 0 ]; then
  echo "✓ All localizations are in sync!"
  exit 0
else
  echo "✗ There are missing localizations that need to be added."
  exit 1
fi