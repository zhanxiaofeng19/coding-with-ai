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
└── bootstrap/                   # 跨项目引入指南
```

## 如何在业务项目中引入

### 方式一：Git Submodule（推荐）

```bash
cd your-business-project
git submodule add <本仓库地址> .ai-standards
```

然后在业务项目中创建 `.cursor/rules/00-import-standards.mdc`：

```markdown
---
description: 引入团队 AI-Coding 规范
alwaysApply: true
---
本项目遵循 .ai-standards/ 下的全部规范。
Agent 必须优先读取 .ai-standards/AGENTS.md 获取完整规范索引。
```

### 方式二：Git Subtree

```bash
git subtree add --prefix=.ai-standards <本仓库地址> main --squash
```

### 方式三：直接复制

将本仓库的 `.cursor/rules/` 和 `specs/` 目录复制到业务项目中。

## 如何定制

1. 填写 `specs/context/` 下的上下文模板，注入项目专属信息
2. 按需修改 `.cursor/rules/02-code-conventions.mdc` 中的命名和包结构约定
3. 按需修改 `.cursor/rules/05-git-workflow.mdc` 中的 Git 规范
4. 在 `specs/context/glossary-template.md` 中补充业务领域词汇

## 如何升级

```bash
cd .ai-standards
git pull origin main
cd ..
git add .ai-standards
git commit -m "chore: upgrade ai-standards"
```

## 版本

当前版本见 [VERSION.md](VERSION.md)，变更记录见 [CHANGELOG.md](CHANGELOG.md)。
