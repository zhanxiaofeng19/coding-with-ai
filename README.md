# AI-Coding 规范框架

一套可复用的 spec-coding 规范仓库。业务项目引入后，AI agent 即可按生产级标准完成从需求到上线的全流程。

## 这个仓库解决什么问题

- Agent 生成的代码不符合团队规范 → `.cursor/rules/` 提供硬约束
- Agent 不知道该先设计再编码 → 工作流编排规则强制阶段推进
- Agent 不了解项目技术栈和基础设施 → `specs/context/` 提供项目画像
- Agent 写完代码没有自检 → 自检规则在编码后自动触发
- 新项目每次都要从零配置 → `bootstrap/` 提供一键引入方案

## 目录结构

```
.
├── AGENTS.md                    # Agent 总入口
├── PLAN.md                      # 构建计划（含待填写项）
├── .cursor/rules/               # Agent 规则文件（.mdc）
│   ├── 00-core-principles       # 核心工程原则
│   ├── 01~05                    # 驱动层：工作流、约定、拆解、自检、Git
│   ├── 06~09                    # 架构与 API 层
│   ├── 10~15                    # 中间件层：MySQL、Redis、MQ、中间件
│   └── 16~20                    # 横切层：可观测、测试、发布、安全、文档
├── specs/
│   ├── context/                 # 项目上下文模板（需按项目填写）
│   ├── templates/               # 技术文档模板
│   ├── standards/               # 详细规范文档
│   ├── examples/                # 示例样本库
│   └── prompts/                 # Prompt 模式库
├── skill/                       # Cursor Skill（一键安装用）
│   └── heytea-standards/
│       ├── SKILL.md             # Skill 入口
│       └── scripts/             # 自动化脚本
└── bootstrap/                   # 跨项目引入指南
```

## 快速开始（一键安装）

**1. 安装 Skill（仅需一次）**

```bash
git clone https://github.com/zhanxiaofeng19/coding-with-ai.git ~/coding-with-ai
cp -r ~/coding-with-ai/skill/heytea-standards ~/.cursor/skills/
```

**2. 在业务项目中使用**

打开 Cursor，对 agent 说"引入开发规范"，自动完成全部初始化。

或手动执行：

```bash
cd your-business-project
bash ~/.cursor/skills/heytea-standards/scripts/setup.sh
```

**3. 填写项目信息** — 编辑 `AGENTS.md` 和 `docs/context/` 下的文件。

详细指南见 [bootstrap/project-import-guide.md](bootstrap/project-import-guide.md)。

---

## 其他引入方式

### Git Submodule

```bash
cd your-business-project
git submodule add <本仓库地址> .ai-standards
mkdir -p .cursor/rules
cp .ai-standards/.cursor/rules/*.mdc .cursor/rules/
```

### Git Subtree

```bash
git subtree add --prefix=.ai-standards <本仓库地址> main --squash
```

### 直接复制

将本仓库的 `.cursor/rules/` 和 `specs/` 目录复制到业务项目中。

## 如何定制

1. 填写 `specs/context/` 下的上下文模板，注入项目专属信息
2. 按需修改 `.cursor/rules/02-code-conventions.mdc` 中的命名和包结构约定
3. 按需修改 `.cursor/rules/05-git-workflow.mdc` 中的 Git 规范
4. 在 `specs/context/glossary-template.md` 中补充业务领域词汇

## 如何升级

**Skill 方式（推荐）**

```bash
bash ~/.cursor/skills/heytea-standards/scripts/upgrade.sh
```

或对 agent 说"升级规范"。

**Submodule 方式**

```bash
cd .ai-standards && git pull origin main && cd ..
git add .ai-standards
git commit -m "chore: upgrade ai-standards"
```

## 版本

当前版本见 [VERSION.md](VERSION.md)，变更记录见 [CHANGELOG.md](CHANGELOG.md)。
