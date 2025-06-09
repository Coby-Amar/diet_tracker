#!/bin/bash

# Hardcoded file name
FILE="pubspec.yaml"

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "Error: '$FILE' not found."
    exit 1
fi

# Extract current version
CURRENT_VERSION=$(grep "^version:" "$FILE" | awk '{print $2}')
if [ -z "$CURRENT_VERSION" ]; then
    echo "No version found. Adding default version 0.0.00."
    CURRENT_VERSION="0.0.00"
    echo "version: $CURRENT_VERSION" >> "$FILE"
fi

# Split version into parts
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"


# Ask user what to increment
read -p "Update version (M = major, m = minor, p = patch): " CHOICE

case "$CHOICE" in
  M)
    ((MAJOR++))
    MINOR=0
    PATCH=0
    ;;
  m)
    ((MINOR++))
    PATCH=0
    ;;
  p)
    ((PATCH++))
    ;;
  *)
    echo "Invalid choice. Use M, m, or p."
    exit 1
    ;;
esac

# Format patch as 2 digits
PATCH=$(printf "%02d" "$PATCH")

# Construct new version string
NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"

# Update version in file
sed -i "s/^version: .*/version: $NEW_VERSION/" "$FILE"
echo "Version updated to $NEW_VERSION in $FILE"

git add "$FILE"

if git diff --cached --quiet; then
    echo "No changes to commit."
else
    git commit -m "chore: bump version to $NEW_VERSION"
    echo "Committed version change."

    git tag $NEW_VERSION
    echo "Added tag for version change."

    echo "Trying to push..."
    if git push; then
        echo "✅ Push successful."
    else
        echo "⚠️ Git push failed. Please check your remote or authentication."
    fi
    echo "Cleaning previous build "
    if flutter clean; then
        echo "✅ Clean successful."
    else
        echo "⚠️ Clean failed. Please check your terminal"
    fi
    echo "Trying to build APK..."
    if flutter build apk; then
        echo "✅ APK build successful."
    else
        echo "⚠️ APK build failed. Please check your terminal."
    fi
fi
