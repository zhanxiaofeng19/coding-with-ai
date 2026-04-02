---
name: heytea-standards
description: >-
  Initialize heytea AI-coding standards in a project. Clone the standards repo,
  copy Cursor rules, set up context templates and AGENTS.md. Use when the user
  wants to set up coding standards, import development guidelines, initialize
  project conventions, or says '引入开发规范', '初始化项目规范', '引入规范'.
  Also handles upgrading standards when the user says '升级规范' or 'upgrade standards'.
---

# Heytea AI-Coding Standards

One-command bootstrap for heytea's spec-coding framework.

## Setup (New Project)

Run the setup script from the project root:

```bash
bash ~/.cursor/skills/heytea-standards/scripts/setup.sh
```

Or execute each step manually:

1. Clone the standards repo:

```bash
git clone git@github.com:heytea/coding-with-ai.git .ai-standards
```

2. Copy rules so Cursor auto-loads them:

```bash
mkdir -p .cursor/rules
cp .ai-standards/.cursor/rules/*.mdc .cursor/rules/
```

3. Copy context templates:

```bash
mkdir -p docs/context
for f in .ai-standards/specs/context/*.md; do
  dest="docs/context/$(basename "$f" | sed 's/-template//')"
  [ ! -f "$dest" ] && cp "$f" "$dest"
done
```

4. Create project AGENTS.md:

```bash
[ ! -f "AGENTS.md" ] && cp .ai-standards/bootstrap/consuming-project-agents-template.md AGENTS.md
```

5. Guide the user to fill in project-specific info in `docs/context/` and `AGENTS.md`.

## Post-Setup

After setup, remind the user to:

- Edit `AGENTS.md` — fill in project name, business domain, tech stack
- Edit `docs/context/project-profile.md` — adjust tech stack if different from heytea defaults
- Edit `docs/context/glossary.md` — add project-specific business terms
- Edit `docs/context/domain-model.md` — define core entities and relationships

## Upgrade Standards

When the user wants to upgrade, run:

```bash
bash ~/.cursor/skills/heytea-standards/scripts/upgrade.sh
```

Or manually:

```bash
cd .ai-standards && git pull origin main && cd ..
cp .ai-standards/.cursor/rules/*.mdc .cursor/rules/
```

## Key Directories

After setup, the project structure looks like:

```
project/
├── .ai-standards/           ← cloned standards repo (source of truth)
├── .cursor/rules/*.mdc      ← copied rules (Cursor auto-loads these)
├── AGENTS.md                ← project-level agent entry point
├── docs/context/            ← project-specific context (filled by user)
└── src/
```

## Available Resources in .ai-standards/

- `specs/templates/` — technical document templates (design docs, API specs, etc.)
- `specs/standards/` — detailed standards documentation
- `specs/examples/` — reference implementations
- `specs/prompts/` — prompt patterns for different task types
- `AGENTS.md` — master rule index

When writing design documents, use templates from `.ai-standards/specs/templates/`.
When referencing coding standards, read from `.ai-standards/specs/standards/`.
When providing code examples, follow patterns from `.ai-standards/specs/examples/`.
