# 业务项目引入指南

## 引入方式

### 方式一：Cursor Skill 一键初始化（推荐）

> 最简单的引入方式。安装一次 Skill，之后任何项目中一句话即可完成初始化。

**Step 1：安装 Skill（仅需一次）**

```bash
# 克隆本仓库（如果还没有）
git clone https://github.com/zhanxiaofeng19/coding-with-ai.git ~/coding-with-ai

# 复制 Skill 到 Cursor 的 skills 目录
cp -r ~/coding-with-ai/skill/heytea-standards ~/.cursor/skills/
```

**Step 2：在业务项目中触发**

在 Cursor 中打开你的业务项目，对 agent 说：

- "引入开发规范"
- "初始化项目规范"
- "setup coding standards"

Agent 会自动读取 Skill 并执行初始化脚本。

**Step 3：填写项目信息**

初始化完成后，编辑以下文件填入实际信息：

- `AGENTS.md` — 项目名称、业务领域、技术栈
- `docs/context/project-profile.md` — 技术架构详情
- `docs/context/glossary.md` — 业务术语表
- `docs/context/domain-model.md` — 核心领域模型

**手动执行（不依赖 Skill）**

也可以直接在业务项目根目录运行脚本：

```bash
bash ~/.cursor/skills/heytea-standards/scripts/setup.sh
# 或指定仓库地址
bash ~/.cursor/skills/heytea-standards/scripts/setup.sh https://github.com/zhanxiaofeng19/coding-with-ai.git
```

---

### 方式二：Git Submodule

```bash
# 1. 在业务项目根目录执行
git submodule add <本仓库地址> .ai-standards

# 2. 创建 .cursor/rules/00-import-standards.mdc
mkdir -p .cursor/rules
```

创建 `.cursor/rules/00-import-standards.mdc`：

```markdown
---
description: 引入团队 AI-Coding 规范
alwaysApply: true
---

本项目遵循 .ai-standards/ 下的全部规范。
Agent 必须优先读取 .ai-standards/AGENTS.md 获取完整规范索引。
编码前必须了解 docs/context/ 下的项目上下文信息。
```

```bash
# 3. 从模板创建项目上下文
mkdir -p docs/context
cp .ai-standards/specs/context/project-profile-template.md docs/context/project-profile.md
cp .ai-standards/specs/context/domain-model-template.md docs/context/domain-model.md
cp .ai-standards/specs/context/glossary-template.md docs/context/glossary.md
cp .ai-standards/specs/context/environment-profile-template.md docs/context/environment-profile.md
cp .ai-standards/specs/context/infrastructure-inventory-template.md docs/context/infrastructure-inventory.md

# 4. 填写项目上下文
# 编辑 docs/context/ 下的文件，填入实际信息

# 5. 创建 AGENTS.md
cp .ai-standards/bootstrap/consuming-project-agents-template.md AGENTS.md
# 编辑 AGENTS.md，填入项目信息

# 6. 提交
git add .
git commit -m "chore: import ai-coding standards"
```

### 方式三：Git Subtree

```bash
git subtree add --prefix=.ai-standards <本仓库地址> main --squash
```

### 方式四：直接复制

```bash
cp -r <本仓库路径>/.cursor/rules/ .cursor/rules/
cp -r <本仓库路径>/specs/ specs/
```

## 引入后的目录结构

### Skill 方式（方式一）

```
business-project/
├── .ai-standards/              ← clone 的规范仓库（升级源）
├── .cursor/
│   └── rules/
│       ├── 00-core-principles.mdc   ← 从 .ai-standards 复制
│       ├── 01-task-lifecycle.mdc
│       ├── ...                      ← 全部 21 个规则文件
│       └── 20-documentation-standards.mdc
├── AGENTS.md                    ← 项目级 agent 入口
├── docs/
│   └── context/                 ← 项目上下文（需填写）
│       ├── project-profile.md
│       ├── domain-model.md
│       ├── glossary.md
│       ├── environment-profile.md
│       └── infrastructure-inventory.md
└── src/
```

### Submodule 方式（方式二）

```
business-project/
├── .ai-standards/              ← submodule 引入的规范仓库
│   ├── .cursor/rules/          ← agent 规则
│   ├── specs/                  ← 规范/模板/示例
│   └── AGENTS.md               ← agent 入口
├── .cursor/
│   └── rules/
│       └── 00-import-standards.mdc  ← 手动创建的引入规则
├── AGENTS.md                    ← 项目级 agent 入口
├── docs/
│   └── context/                 ← 项目上下文（需填写）
└── src/
```

## 升级

### Skill 方式升级

对 agent 说"升级规范"，或手动执行：

```bash
bash ~/.cursor/skills/heytea-standards/scripts/upgrade.sh
```

### Submodule 方式升级

```bash
cd .ai-standards
git pull origin main
cd ..
git add .ai-standards
git commit -m "chore: upgrade ai-standards to latest"
```

## 定制

如果需要覆盖某些规则：
1. 在项目的 `.cursor/rules/` 下创建同名规则文件
2. Cursor 会优先使用项目自身的规则
3. 在规则中注明覆盖原因
