#!/bin/bash
set -euo pipefail

REPO_URL="${1:-git@github.com:heytea/coding-with-ai.git}"
STANDARDS_DIR=".ai-standards"

echo "=== Heytea AI-Coding Standards Setup ==="

# 1. Clone standards repo
if [ -d "$STANDARDS_DIR" ]; then
    echo "[1/4] Standards repo already exists, pulling latest..."
    cd "$STANDARDS_DIR" && git pull origin main && cd ..
else
    echo "[1/4] Cloning standards repo..."
    git clone "$REPO_URL" "$STANDARDS_DIR"
fi

# 2. Copy rules to .cursor/rules/ (Cursor only auto-loads from project root)
echo "[2/4] Copying Cursor rules..."
mkdir -p .cursor/rules
cp "$STANDARDS_DIR/.cursor/rules/"*.mdc .cursor/rules/
echo "  -> Copied $(ls .cursor/rules/*.mdc 2>/dev/null | wc -l | tr -d ' ') rule files"

# 3. Copy context templates (skip if already exists to preserve user edits)
echo "[3/4] Setting up context templates..."
mkdir -p docs/context
copied=0
for f in "$STANDARDS_DIR/specs/context/"*.md; do
    filename=$(basename "$f")
    dest="docs/context/${filename//-template/}"
    if [ ! -f "$dest" ]; then
        cp "$f" "$dest"
        copied=$((copied + 1))
    fi
done
echo "  -> Copied $copied new template(s), skipped existing"

# 4. Create AGENTS.md from template
echo "[4/4] Setting up AGENTS.md..."
if [ ! -f "AGENTS.md" ]; then
    cp "$STANDARDS_DIR/bootstrap/consuming-project-agents-template.md" AGENTS.md
    echo "  -> Created AGENTS.md"
else
    echo "  -> AGENTS.md already exists, skipped"
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit AGENTS.md         — fill in project name, domain, tech stack"
echo "  2. Edit docs/context/     — fill in project-specific context"
echo "  3. git add . && git commit -m 'chore: 引入 ai-coding 规范'"
echo ""
echo "Available resources in $STANDARDS_DIR/:"
echo "  specs/templates/  — document templates"
echo "  specs/standards/  — detailed standards"
echo "  specs/examples/   — reference implementations"
echo "  specs/prompts/    — prompt patterns"
