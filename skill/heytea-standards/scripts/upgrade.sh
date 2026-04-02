#!/bin/bash
set -euo pipefail

STANDARDS_DIR=".ai-standards"

echo "=== Heytea AI-Coding Standards Upgrade ==="

if [ ! -d "$STANDARDS_DIR" ]; then
    echo "Error: $STANDARDS_DIR not found. Run setup.sh first."
    exit 1
fi

# 1. Pull latest
echo "[1/2] Pulling latest standards..."
cd "$STANDARDS_DIR" && git pull origin main && cd ..

# 2. Overwrite rules (rules are managed by the standards repo, safe to overwrite)
echo "[2/2] Updating Cursor rules..."
cp "$STANDARDS_DIR/.cursor/rules/"*.mdc .cursor/rules/
echo "  -> Updated $(ls .cursor/rules/*.mdc 2>/dev/null | wc -l | tr -d ' ') rule files"

echo ""
echo "=== Upgrade Complete ==="
echo ""
echo "Note: docs/context/ and AGENTS.md were NOT overwritten (project-specific)."
echo "Check $STANDARDS_DIR/CHANGELOG.md for what changed."
