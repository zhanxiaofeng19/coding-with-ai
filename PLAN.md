# AI-Coding 规范框架 — 完整构建计划

> 目标：构建一套可复用的 spec-coding 规范仓库，任何业务项目引入后即可驱动 agent 按生产级标准完成从需求到上线的全流程。

---

## 一、框架分层架构

```
┌─────────────────────────────────────────────────────┐
│                  骨架层 (Skeleton)                    │
│   README.md / AGENTS.md / VERSION / CHANGELOG       │
├─────────────────────────────────────────────────────┤
│              驱动层 (Workflow & Process)              │
│   工作流编排 / 任务拆解 / 自检Review / Git工作流        │
├─────────────────────────────────────────────────────┤
│              约定层 (Code Conventions)                │
│   代码生成约定 / 包结构 / 命名 / 错误码                 │
├─────────────────────────────────────────────────────┤
│              约束层 (Standards & Constraints)         │
│   MySQL / Redis / MQ / 中间件 / 高可用 / 安全 / 可观测  │
├─────────────────────────────────────────────────────┤
│              上下文层 (Project Context)               │
│   项目画像 / 领域模型 / 基础设施 / 环境 / 领域词汇        │
├─────────────────────────────────────────────────────┤
│              模板层 (Templates)                       │
│   需求 / 技术设计 / API / 表设计 / 缓存 / MQ / 发布等   │
├─────────────────────────────────────────────────────┤
│              示例层 (Examples)                        │
│   标准 CRUD / MQ 消费者 / 分布式锁 / 异常处理 / HA 设计  │
├─────────────────────────────────────────────────────┤
│              Prompt 模式层 (Prompt Patterns)          │
│   新功能 / Bug修复 / 重构 / 性能优化 / 故障排查          │
├─────────────────────────────────────────────────────┤
│              引导层 (Bootstrap)                       │
│   项目引入指南 / 消费方 AGENTS 模板                     │
└─────────────────────────────────────────────────────┘
```

---

## 二、完整文件清单（共约 60 个文件）

### 第 1 批：骨架层（4 个文件）

| # | 文件路径 | 用途 | 需要你补充 |
|---|---------|------|----------|
| 1 | `README.md` | 项目说明：这个仓库是什么、怎么引入、怎么升级 | 否 |
| 2 | `AGENTS.md` | Agent 总入口：告诉 agent 优先读取哪些规则、使用哪些模板 | 否 |
| 3 | `VERSION.md` | 版本号管理 | 否 |
| 4 | `CHANGELOG.md` | 变更记录 | 否 |

---

### 第 2 批：`.cursor/rules/` 规则文件（21 个 `.mdc` 文件）

所有规则文件由我直接生成，以下标注"需要你补充"的部分会在文件内以 `<!-- Q: ... -->` 格式标记。

| # | 文件路径 | 用途 | 需要你补充 |
|---|---------|------|----------|
| 1 | `.cursor/rules/00-core-principles.mdc` | 全局工程原则 | 否 |
| 2 | `.cursor/rules/01-task-lifecycle.mdc` | 工作流编排：需求→设计→拆解→编码→自检→测试→发布 | 否 |
| 3 | `.cursor/rules/02-code-conventions.mdc` | 代码生成约定：包结构、命名、错误码、公共基类 | **是** |
| 4 | `.cursor/rules/03-task-decomposition.mdc` | 任务拆解规则 | 否 |
| 5 | `.cursor/rules/04-self-review.mdc` | 编码后自检规则 | 否 |
| 6 | `.cursor/rules/05-git-workflow.mdc` | Git 分支/Commit/PR 规范 | **是** |
| 7 | `.cursor/rules/06-spec-driven-workflow.mdc` | 编码前必须先补齐设计文档 | 否 |
| 8 | `.cursor/rules/07-backend-architecture.mdc` | 后端分层架构约束 | 否 |
| 9 | `.cursor/rules/08-api-design.mdc` | C端接口设计规范 | 否 |
| 10 | `.cursor/rules/09-api-availability-concurrency.mdc` | 高可用高并发专项约束 | 否 |
| 11 | `.cursor/rules/10-mysql-design.mdc` | MySQL 表设计规范 | 否 |
| 12 | `.cursor/rules/11-mysql-sql-review.mdc` | SQL 编写与 Review 规范 | 否 |
| 13 | `.cursor/rules/12-redis-design.mdc` | Redis 数据建模规范 | 否 |
| 14 | `.cursor/rules/13-redis-cache-safety.mdc` | Redis 缓存安全与一致性规范 | 否 |
| 15 | `.cursor/rules/14-mq-design.mdc` | 消息队列设计规范 | 否 |
| 16 | `.cursor/rules/15-middleware-resilience.mdc` | 中间件韧性约束 | 否 |
| 17 | `.cursor/rules/16-observability.mdc` | 可观测性规范 | 否 |
| 18 | `.cursor/rules/17-testing-quality.mdc` | 测试与质量规范 | 否 |
| 19 | `.cursor/rules/18-release-change-management.mdc` | 发布与变更管理规范 | 否 |
| 20 | `.cursor/rules/19-security-baseline.mdc` | 安全基线规范 | 否 |
| 21 | `.cursor/rules/20-documentation-standards.mdc` | 技术文档编写标准 | 否 |

---

### 第 3 批：`specs/` 规范文档（35 个文件）

#### 3.1 `specs/context/` — 项目上下文（需要你补充，5 个文件）

这些是模板文件，文件内会用 `<!-- Q: ... -->` 标记你需要回答的问题，并附带回答示例。
在你的业务项目中使用时，复制模板并填入实际信息即可。

| # | 文件路径 | 用途 |
|---|---------|------|
| 1 | `specs/context/project-profile-template.md` | 项目画像：技术栈、基础设施、服务拓扑 |
| 2 | `specs/context/domain-model-template.md` | 领域模型：核心实体、聚合根、限界上下文 |
| 3 | `specs/context/infrastructure-inventory-template.md` | 基础设施清单 |
| 4 | `specs/context/environment-profile-template.md` | 环境画像：dev/staging/prod 差异 |
| 5 | `specs/context/glossary-template.md` | 领域词汇表 |

#### 3.2 `specs/templates/` — 文档模板（15 个文件）

| # | 文件路径 | 用途 |
|---|---------|------|
| 1 | `specs/templates/requirement-spec-template.md` | 需求规格说明模板 |
| 2 | `specs/templates/technical-design-template.md` | 技术设计文档模板 |
| 3 | `specs/templates/api-design-template.md` | API 设计文档模板 |
| 4 | `specs/templates/mysql-schema-template.md` | MySQL 表设计文档模板 |
| 5 | `specs/templates/redis-key-design-template.md` | Redis Key 设计文档模板 |
| 6 | `specs/templates/mq-topic-consumer-template.md` | MQ Topic/Consumer 设计文档模板 |
| 7 | `specs/templates/middleware-integration-template.md` | 中间件集成文档模板 |
| 8 | `specs/templates/high-availability-checklist-template.md` | 高可用检查清单模板 |
| 9 | `specs/templates/test-plan-template.md` | 测试计划模板 |
| 10 | `specs/templates/release-plan-template.md` | 发布计划模板 |
| 11 | `specs/templates/incident-runbook-template.md` | 故障 Runbook 模板 |
| 12 | `specs/templates/task-lifecycle-checklist.md` | 任务生命周期检查清单 |
| 13 | `specs/templates/task-breakdown-template.md` | 任务拆解模板 |
| 14 | `specs/templates/code-review-checklist-template.md` | Code Review 检查清单 |
| 15 | `specs/templates/pull-request-template.md` | Pull Request 模板 |

#### 3.3 `specs/standards/` — 详细规范文档（15 个文件）

| # | 文件路径 | 用途 |
|---|---------|------|
| 1 | `specs/standards/engineering-principles.md` | 工程原则详解 |
| 2 | `specs/standards/backend-development-guidelines.md` | 后端开发准则 |
| 3 | `specs/standards/c-end-api-sla-slo.md` | C端接口 SLA/SLO 定义 |
| 4 | `specs/standards/mysql-standards.md` | MySQL 完整规范 |
| 5 | `specs/standards/redis-standards.md` | Redis 完整规范 |
| 6 | `specs/standards/mq-standards.md` | MQ 完整规范 |
| 7 | `specs/standards/middleware-standards.md` | 中间件通用规范 |
| 8 | `specs/standards/observability-standards.md` | 可观测性规范 |
| 9 | `specs/standards/security-standards.md` | 安全规范 |
| 10 | `specs/standards/testing-standards.md` | 测试规范 |
| 11 | `specs/standards/package-structure-standards.md` | 包结构规范 |
| 12 | `specs/standards/naming-conventions.md` | 命名规范 |
| 13 | `specs/standards/error-code-allocation.md` | 错误码分配规范 |
| 14 | `specs/standards/feature-flag-standards.md` | 特性开关规范 |
| 15 | `specs/standards/gray-release-standards.md` | 灰度发布规范 |

---

### 第 4 批：示例 + Prompt 模式 + 引导（14 个文件）

#### 4.1 `specs/examples/` — 示例样本库（7 个文件）

| # | 文件路径 | 用途 |
|---|---------|------|
| 1 | `specs/examples/sample-crud-service.md` | 标准 CRUD 服务全栈示例 |
| 2 | `specs/examples/sample-api-spec.md` | API 设计文档填写示例 |
| 3 | `specs/examples/sample-redis-design.md` | Redis Key 设计填写示例 |
| 4 | `specs/examples/sample-ha-design.md` | 高可用设计填写示例 |
| 5 | `specs/examples/sample-mq-consumer.md` | MQ 消费者实现示例 |
| 6 | `specs/examples/sample-distributed-lock.md` | 分布式锁使用示例 |
| 7 | `specs/examples/sample-error-handling.md` | 异常处理与降级示例 |

#### 4.2 `specs/prompts/` — Prompt 模式库（5 个文件）

| # | 文件路径 | 用途 |
|---|---------|------|
| 1 | `specs/prompts/new-feature-prompt.md` | 新功能开发 prompt 模板 |
| 2 | `specs/prompts/bug-fix-prompt.md` | Bug 修复 prompt 模板 |
| 3 | `specs/prompts/refactoring-prompt.md` | 重构 prompt 模板 |
| 4 | `specs/prompts/performance-optimization-prompt.md` | 性能优化 prompt 模板 |
| 5 | `specs/prompts/incident-investigation-prompt.md` | 故障排查 prompt 模板 |

#### 4.3 `bootstrap/` — 引导文件（2 个文件）

| # | 文件路径 | 用途 |
|---|---------|------|
| 1 | `bootstrap/project-import-guide.md` | 业务项目引入本仓库的操作指南 |
| 2 | `bootstrap/consuming-project-agents-template.md` | 消费方项目的 AGENTS.md 模板 |

---

## 三、需要你补充的内容

以下是需要你提供信息的文件，每个问题附带回答示例。
你可以直接在本文件中填写，build 阶段我会把你的回答写入对应文件。

---

### Q1：代码生成约定 → `.cursor/rules/02-code-conventions.mdc`

#### Q1.1 你们的项目分层包结构是什么？

> **回答示例：**
> ```
> com.company.project
> ├── controller      // 接口层
> ├── service          // 业务层
> │   └── impl
> ├── manager          // 通用业务层（跨service复用、第三方封装）
> ├── mapper           // 持久层（MyBatis Mapper）
> ├── domain
> │   ├── entity       // 数据库实体
> │   ├── dto          // 数据传输对象
> │   ├── vo           // 视图对象
> │   ├── bo           // 业务对象
> │   └── enums        // 枚举
> ├── config           // 配置类
> ├── common
> │   ├── exception    // 异常定义
> │   ├── constant     // 常量
> │   └── util         // 工具类
> └── infrastructure   // 基础设施（MQ、缓存、外部服务封装）
> ```

**你的回答：**
> ```
> com.heytea.project
> ├── entrance         // entrance (适配层)：包含 controller、scheduler、consumer
> │   ├── controller   // restful接口
> │   ├── scheduler    // 定时任务调度接口
> │   ├── consumer     // 消费者接口
> ├── service          // service (应用层)：包含 service、executor，使用 DTO
> │   └── impl
> ├── domain           // 领域层 - 领域模型和业务逻辑
> │   ├── 模块名称1     // 模块名称1
> │   │  ├── entity    // 数据库实体
> │   │  ├── dto       // 数据传输对象
> │   │  ├── vo        // 视图对象
> │   │  ├── bo        // 业务对象
> │   │  └── enums     // 枚举
> │   ├── 模块名称..    // 模块名称..
> └── infrastructure   // 基础设施（数据库、MQ、缓存、外部服务封装、统一配置）
>     ├── constant     // 常量
>     ├── exceptions   // 异常定义
>     ├── config       // 配置类
>     ├── utils        // 工具类
>     ├── mq           // mq 配置
>     ├── redis        // redis 配置
>     ├── client       // 客户端层 - API 接口和 DTO 定义
>     └── repository   // 数据访问封装
> ```
ps:若项目名称是，manager-member-premium 那么project=manager.member.premium
---

#### Q1.2 你们的命名约定有哪些自定义规则？

> **回答示例：**
> - Controller: `XxxController`
> - Service 接口: `XxxService`，实现: `XxxServiceImpl`
> - Mapper: `XxxMapper`（MyBatis-Plus 风格）
> - Entity: `XxxDO`（阿里规范）或 `XxxEntity`
> - DTO: `XxxReqDTO` / `XxxRespDTO`
> - VO: `XxxVO`
> - BO: `XxxBO`
> - Config: `XxxConfig` / `XxxProperties`
> - 常量: `XxxConstants`
> - 枚举: `XxxEnum`
> - 异常: `XxxException`
> - Event: `XxxEvent`

**你的回答：**
> - 简洁清晰,符合大众理解
---

#### Q1.3 你们的错误码格式是什么？

> **回答示例：**
> - 格式：`模块编号(2位) + 错误类型(1位) + 序号(3位)`
> - 示例：`10_1_001` → 订单模块_参数错误_第1个
> - 或者用字符串形式：`ORDER_PARAM_001`
> - 或者纯数字：`101001`
> - 公共错误码段：`00_x_xxx`
> - 每个业务模块分配固定前缀

**你的回答：**

> - 错误码严格按照规范定义! 若是 [系统级异常] 需定义在 [SystemErrorEnum.java] 文件中，[业务异常]放在[BizErrorEnum.java]
> - 格式：`应用领域(1位) + 应用标识(3位)+ 错误类型(1位) + 预留位(1位) + 错误码(3位)`
> - 示例：如下
    /**
     * 
     * 示例: 5_660_1_0_001
     * 
     * [6]   [660]   [1]    [0]   [001]
     *  ↑      ↑      ↑      ↑      ↑
     *  应     应     错     预     错
     *  用     用     误     留     误
     *  领     标     类     位     码
     *  域     识     型    (1位)  (3位)
     * (1位)  (3位)  (1位)
     *                            
     * 应用领域：会员为 5
     * 应用标识：660, Apollo项目Id 
     * 错误类型：
     *  0 系统错误
     *  x 其他为业务错误
     * 预留位置：预留位置当前无分配后续存在则在此更新 
     * 业务错误码：一个应用的错误码在000-999之间分配
     */


---

#### Q1.4 你们有哪些已封装的公共基类/工具？

> **回答示例：**
> - 统一响应：`Result<T>` / `R<T>`
> - 分页请求：`PageQuery(pageNum, pageSize)`
> - 分页响应：`PageResult<T>(list, total, pageNum, pageSize)`
> - 基础异常：`BizException(code, msg)` / `SystemException`
> - 断言工具：`BizAssert.notNull(obj, errorCode)`
> - 分布式ID：`IdGenerator.nextId()`
> - 日志工具：`TraceLogUtil.info/warn/error`（自动带traceId）
> - Redis 工具：`RedisHelper`（已封装序列化、前缀、TTL）

**你的回答：**

> - 统一响应：`BaseResult<T>` / `R<T>`
> - 分页请求：`定义自己的requests extends BasePageForm`
> - 分页响应：`BasePageVO<T>(list, total, pageNum, pageSize)`
> - 基础异常：`BizException(code, msg)` / `SystemException`
> - 分布式ID：`HeyteaUidGenerator.generateUid()`
> - Redis 工具：`HeyteaCache`（已封装序列化、前缀、TTL）

ps:公共基类来源于：heytea-spring-boot-core 依赖
---

### Q2：Git 工作流 → `.cursor/rules/05-git-workflow.mdc`

#### Q2.1 你们的分支命名策略？

> **回答示例：**
> - 主分支：`main` / `master`
> - 开发分支：`develop`
> - 功能分支：`feature/JIRA-1234-short-desc`
> - 修复分支：`fix/JIRA-1234-short-desc`
> - 热修分支：`hotfix/JIRA-1234-short-desc`
> - 发布分支：`release/v1.2.0`
> - 项目管理工具：蓝鲸

**你的回答：**

> - 主分支：`main` / `master`
> - 开发分支：`develop`
> - 功能分支：`feature/JIRA-1234-short-desc`
> - 修复分支：`fix/JIRA-1234-short-desc`
> - 热修分支：`hotfix/JIRA-1234-short-desc`
> - 发布分支：`release/v1.2.0`
> - 项目管理工具：蓝鲸
构建分支时询问蓝鲸需求编码；示例：p_23123

---

#### Q2.2 你们的 Commit Message 格式？

> **回答示例：**
> - 格式：`type(scope): description`
> - type 枚举：feat / fix / refactor / perf / test / docs / chore / ci
> - scope：模块名，如 order / payment / user
> - 示例：`feat(order): add order creation API`
> - 要求关联蓝鲸需求号：是，放在 body 里 `Refs: p_23123`
> - 语言：中文

**你的回答：**
> - 格式：`type(scope): description`
> - type 枚举：feat / fix / refactor / perf / test / docs / chore / ci
> - scope：模块名，如 order / payment / user
> - 示例：`feat(order): add order creation API`
> - 要求关联蓝鲸需求号：是，放在 body 里 `Refs: p_23123`
> - 语言：中文

---

#### Q2.3 你们的 PR 规则？

> **回答示例：**
> - 单个 PR 最大行数：500 行（不含测试）
> - 是否要求 Review 审批：是，至少 1 人
> - DDL 变更是否必须独立 PR：是
> - PR 描述必须包含：背景、改动点、影响范围、测试方式、回滚方案

**你的回答：**
> - 单个 PR 最大行数：500 行（不含测试）
> - 是否要求 Review 审批：是，至少 1 人
> - DDL 变更是否必须独立 PR：是
> - PR 描述必须包含：背景、改动点、影响范围、测试方式、回滚方案

---

### Q3：项目上下文 → `specs/context/`

#### Q3.1 你的主要技术栈？

**你的回答：**

> - 语言：Java 1.8
> - 框架：Spring Boot 2.3.1
> - 构建：Maven
> - ORM：MyBatis-Plus 3.2
> - 数据库：MySQL 8.0（单库 / 分库分表-ShardingSphere）还有 MySQL 5.7
> - 缓存：Redis 7.x Cluster（Lettuce / Redisson）
> - 消息队列：RocketMQ 5.x / Kafka 3.x
> - RPC：OpenFeign / okhttp / hystrix
> - 注册中心：Nacos 2.x
> - 配置中心：Nacos / Apollo
> - 网关：Spring Cloud Gateway / Kong
> - 搜索：Elasticsearch 8.x

---

#### Q3.2 你的基础设施清单？
**你的回答：**

> - 日志采集：云服务 cls
> - 监控告警：Prometheus + Grafana + AlertManager
> - 任务调度：XXL-Job
> - 分布式ID：Leaf / Snowflake
> - 对象存储：阿里云 OSS
> - 短信/推送：自研网关 / 第三方
> - 风控：自研规则引擎
> - 容器化：K8s + Docker
> - CI/CD：Jenkins

---

#### Q3.3 你的 C 端 SLA/SLO 目标？

**你的回答：**

> - 核心接口 P99 延迟：≤ 200ms
> - 核心接口 P999 延迟：≤ 500ms
> - 可用性目标：99.95%（月度）
> - 错误率阈值：< 0.1%
> - 核心接口 QPS 基线：2000+
> - 峰值倍数假设：日常的 3-5 倍
> - 降级触发阈值：错误率 > 5% 或 P99 > 1s

---

#### Q3.4 你的典型业务领域（用于生成示例和词汇表）？

> - 用户会员（登录、主用户 userMain、渠道用户 oauthUser、灵感经验值、积分、付费会员、学生会员、星球会员、权益、特权）
> - 营销活动（优惠券、活动、抽奖、折扣）
> - 商品菜单（门店、商品、库存、菜单）

---

#### Q3.5 你的环境划分？

> **回答示例：**
> - 开发环境（dev）：单节点、mock 外部依赖、宽松限流
> - 测试环境（test/staging）：接近生产配置、共享 DB、有基本监控
> - 预发环境（pre）：连生产 DB（只读）、完整链路、灰度验证
> - 生产环境（prod）：多副本、严格限流、完整监控告警
> - 是否有多机房/多 AZ：是 / 否

**你的回答：**
> - 开发环境（dev）：单节点、mock 外部依赖、宽松限流
> - 测试环境（test/staging）：接近生产配置、共享 DB、有基本监控
> - 预发环境（pre）：连生产 DB（只读）、完整链路、灰度验证
> - 生产环境（prod）：多副本、严格限流、完整监控告警
> - 是否有多机房/多 AZ：是

---

#### Q4.1 你们有内部 SDK/Starter 吗？agent 在生成代码时需要知道的已有封装？
是的，需要

> **回答示例：**
> - `company-spring-boot-starter-redis` — Redis 操作封装
> - `company-spring-boot-starter-mq` — MQ 生产者/消费者封装
> - `company-spring-boot-starter-log` — 结构化日志 + traceId
> - `company-common-util` — 通用工具类

**你的回答：**
> - `heytea-spring-boot-core` — 通用工具封装包括（redis-template，OSS，接口统一响应体）
---

#### Q4.2 你们的特性开关/灰度方案？

> **回答示例：**
> - 使用 Nacos 配置作为开关
> - 或用 LaunchDarkly / Unleash / 自研灰度中心
> - 灰度维度：用户 ID 尾号 / 城市 / 渠道 / 百分比

**你的回答：**

> - 特性开关通过 apollo 配置控制
> - 灰度按用户 Id 尾号

---

#### Q4.3 你们的分布式事务方案？

> **回答示例：**
> - 优先本地事务 + 消息最终一致
> - Seata AT 模式（仅跨库场景）
> - TCC（资金相关）
> - Saga（长流程编排）

**你的回答：**

> - 优先本地事务 + 消息最终一致
> - 记录状态的扭转检查、任务补偿等机制保证最终一致性

---

## 四、构建执行计划

确认 plan 后，按以下 4 批顺序执行 build：

### Batch 1：骨架层（4 个文件）
- `README.md` — 项目说明 + 引入指南
- `AGENTS.md` — Agent 总入口
- `VERSION.md` — 初始版本 `v1.0.0`
- `CHANGELOG.md` — 初始记录

### Batch 2：规则层（21 个 `.mdc` 文件）
- `.cursor/rules/00-core-principles.mdc`
- `.cursor/rules/01-task-lifecycle.mdc`
- `.cursor/rules/02-code-conventions.mdc` ← 含你补充的约定
- `.cursor/rules/03-task-decomposition.mdc`
- `.cursor/rules/04-self-review.mdc`
- `.cursor/rules/05-git-workflow.mdc` ← 含你补充的 Git 规范
- `.cursor/rules/06-spec-driven-workflow.mdc`
- `.cursor/rules/07-backend-architecture.mdc`
- `.cursor/rules/08-api-design.mdc`
- `.cursor/rules/09-api-availability-concurrency.mdc`
- `.cursor/rules/10-mysql-design.mdc`
- `.cursor/rules/11-mysql-sql-review.mdc`
- `.cursor/rules/12-redis-design.mdc`
- `.cursor/rules/13-redis-cache-safety.mdc`
- `.cursor/rules/14-mq-design.mdc`
- `.cursor/rules/15-middleware-resilience.mdc`
- `.cursor/rules/16-observability.mdc`
- `.cursor/rules/17-testing-quality.mdc`
- `.cursor/rules/18-release-change-management.mdc`
- `.cursor/rules/19-security-baseline.mdc`
- `.cursor/rules/20-documentation-standards.mdc`

### Batch 3：规范文档层（35 个文件）
- `specs/context/` — 5 个上下文模板（含你补充的信息）
- `specs/templates/` — 15 个文档模板
- `specs/standards/` — 15 个详细规范

### Batch 4：示例 + Prompt + 引导（14 个文件）
- `specs/examples/` — 7 个代码/设计示例
- `specs/prompts/` — 5 个 Prompt 模式
- `bootstrap/` — 2 个引导文件

---

## 五、跨项目复用方式

业务项目引入本仓库后的结构：

```
business-project/
├── .ai-standards/              ← git submodule 引入本仓库
│   ├── .cursor/rules/
│   ├── specs/
│   └── ...
├── .cursor/
│   └── rules/
│       └── 00-import-standards.mdc  ← 唯一新增：指向 .ai-standards
├── AGENTS.md                    ← 从 bootstrap/ 模板生成
├── docs/
│   ├── design/                  ← 使用 specs/templates/ 编写
│   └── context/                 ← 从 specs/context/ 模板填写
└── src/
```

---
