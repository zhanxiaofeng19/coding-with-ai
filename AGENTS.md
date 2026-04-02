# Agent 指令入口

你是一个遵循 spec-coding 规范的 AI 编码助手。在本项目（或引入本项目作为子模块的业务项目）中工作时，必须遵循以下规则。

## 规则优先级

1. `.cursor/rules/` 下的 `.mdc` 规则文件为最高优先级约束
2. `specs/standards/` 下的详细规范为补充说明
3. `specs/context/` 下的项目上下文为编码基础信息
4. `specs/templates/` 下的模板为产出物格式要求
5. `specs/examples/` 下的示例为参考实现

## 工作流程

每次接到需求时，必须按以下阶段推进（详见 `01-task-lifecycle.mdc`）：

1. **需求澄清** — 确认目标、边界、非目标
2. **技术设计** — 使用 `specs/templates/technical-design-template.md` 输出设计文档
3. **任务拆解** — 使用 `specs/templates/task-breakdown-template.md` 拆解任务
4. **编码实现** — 遵循所有 `.mdc` 规则
5. **自检 Review** — 按 `04-self-review.mdc` 执行检查清单
6. **测试补充** — 补充单测和集成测试
7. **发布准备** — 使用 `specs/templates/release-plan-template.md` 准备发布

## 规则索引

### 驱动层（必须遵循的工作流程规则）

| 规则文件 | 用途 |
|---------|------|
| `00-core-principles.mdc` | 全局工程原则 |
| `01-task-lifecycle.mdc` | 需求→设计→编码→测试→发布的阶段编排 |
| `02-code-conventions.mdc` | 包结构、命名、错误码、公共基类 |
| `03-task-decomposition.mdc` | 任务拆解规则 |
| `04-self-review.mdc` | 编码后自检清单 |
| `05-git-workflow.mdc` | 分支、Commit、PR 规范 |
| `06-spec-driven-workflow.mdc` | 编码前必须先输出设计文档 |

### 约束层（编码时必须遵循的技术规范）

| 规则文件 | 用途 |
|---------|------|
| `07-backend-architecture.mdc` | 后端分层架构 |
| `08-api-design.mdc` | C 端接口设计 |
| `09-api-availability-concurrency.mdc` | 高可用高并发 |
| `10-mysql-design.mdc` | MySQL 表设计 |
| `11-mysql-sql-review.mdc` | SQL 编写规范 |
| `12-redis-design.mdc` | Redis 数据建模 |
| `13-redis-cache-safety.mdc` | 缓存安全与一致性 |
| `14-mq-design.mdc` | 消息队列设计 |
| `15-middleware-resilience.mdc` | 中间件韧性 |
| `16-observability.mdc` | 可观测性 |
| `17-testing-quality.mdc` | 测试与质量 |
| `18-release-change-management.mdc` | 发布与变更 |
| `19-security-baseline.mdc` | 安全基线 |
| `20-documentation-standards.mdc` | 文档标准 |

## 模板索引

需要输出设计文档时，使用 `specs/templates/` 下的对应模板：

- 需求规格 → `requirement-spec-template.md`
- 技术设计 → `technical-design-template.md`
- API 设计 → `api-design-template.md`
- 表结构设计 → `mysql-schema-template.md`
- Redis 设计 → `redis-key-design-template.md`
- MQ 设计 → `mq-topic-consumer-template.md`
- 高可用检查 → `high-availability-checklist-template.md`
- 测试计划 → `test-plan-template.md`
- 发布计划 → `release-plan-template.md`
- 故障 Runbook → `incident-runbook-template.md`

## Prompt 模式

根据任务类型选择对应的 prompt 模式（`specs/prompts/`）：

- 新功能开发 → `new-feature-prompt.md`
- Bug 修复 → `bug-fix-prompt.md`
- 代码重构 → `refactoring-prompt.md`
- 性能优化 → `performance-optimization-prompt.md`
- 故障排查 → `incident-investigation-prompt.md`

## 项目上下文

编码前必须了解项目画像（`specs/context/`）：

- 技术栈与基础设施 → `project-profile-template.md`
- 领域模型 → `domain-model-template.md`
- 领域词汇 → `glossary-template.md`
- 环境差异 → `environment-profile-template.md`

## 输出语言

所有面向用户的输出使用中文。代码注释、变量名、commit message 使用英文。
