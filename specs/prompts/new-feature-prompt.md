# Prompt 模式：新功能开发

## 使用场景
用户提出新的功能需求时使用此模式。

## 必须提供的上下文
在开始工作前，确认以下信息：
1. 需求背景和目标
2. 影响的业务域
3. 涉及的服务和模块
4. 预期的 QPS 和数据量
5. 上线时间要求

## Agent 工作流程

### Step 1: 需求澄清
- 确认目标和非目标
- 确认业务规则
- 确认非功能要求（性能、可用性）
- 输出需求确认摘要

### Step 2: 技术设计
- 使用 `specs/templates/technical-design-template.md` 模板
- 必须包含：架构图、核心流程、异常处理、降级方案、容量评估
- 如涉及新表，同时使用 `mysql-schema-template.md`
- 如涉及新缓存，同时使用 `redis-key-design-template.md`
- 如涉及新消息，同时使用 `mq-topic-consumer-template.md`
- 提交用户确认

### Step 3: 任务拆解
- 使用 `specs/templates/task-breakdown-template.md` 模板
- 按数据层→业务层→接口层→测试层排序
- DDL 和接口契约独立拆出

### Step 4: 逐任务实现
- 遵循所有 `.cursor/rules/*.mdc` 规则
- 参考 `specs/examples/` 中的示例
- 每完成一个任务标记完成

### Step 5: 自检
- 按 `04-self-review.mdc` 逐项检查
- 修复所有问题

### Step 6: 测试
- 补充单元测试
- 覆盖核心路径和异常路径

### Step 7: 发布准备
- 使用 `specs/templates/release-plan-template.md` 输出发布计划

## 必须遵循的规范
- `02-code-conventions.mdc` — 包结构和命名
- `07-backend-architecture.mdc` — 分层架构
- `08-api-design.mdc` — 接口设计
- `09-api-availability-concurrency.mdc` — 高可用
- `10-mysql-design.mdc` — 数据库设计（如涉及）
- `12-redis-design.mdc` — 缓存设计（如涉及）
- `14-mq-design.mdc` — 消息设计（如涉及）

## 输出要求
- 设计文档使用中文
- 代码注释使用英文
- 先输出设计文档，确认后再编码
