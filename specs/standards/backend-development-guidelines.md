# 后端开发准则

## 分层职责

### Entrance（适配层）
- Controller：参数校验（@Valid / @Validated）、协议转换（HTTP → DTO）、调用 Service
- Consumer：MQ 消息接收、幂等检查、调用 Service
- Scheduler：定时任务触发、调用 Service
- 不包含业务逻辑

### Service（应用层）
- 业务逻辑编排
- 事务管理
- 无状态
- 不暴露实现细节

### Domain（领域层）
- 领域模型定义（Entity / DTO / VO / BO / Enum）
- 按业务模块划分子包
- 不依赖 Spring 框架

### Infrastructure（基础设施层）
- Repository：数据访问封装
- Client：外部服务调用（Feign / OkHttp）
- MQ/Redis/OSS 等中间件配置
- 常量、异常、工具类

## 编码准则

### 依赖注入
- 使用构造器注入
- 使用 @RequiredArgsConstructor
- 禁止 @Autowired 字段注入

### 异常处理
- 业务异常使用 BizException
- 系统异常使用 SystemException
- 全局异常处理器统一捕获
- 异常信息包含上下文（userId、orderId 等）

### 参数校验
- 入口参数使用注解校验
- 业务规则使用 BizAssert 断言
- 校验失败返回明确的错误码和消息

### 日志
- 方法入口打印关键参数
- 异常打印 error 日志（含上下文）
- 关键分支打印 info/warn 日志
- 禁止在循环中打印日志

### 事务
- 事务只加在 Service 层
- 事务范围最小化
- 事务内禁止远程调用
- 只读操作标注 readOnly

### 并发
- 共享状态加锁保护
- 优先使用无锁方案（CAS、不可变对象）
- 线程池有界且命名
- 异步任务传递 traceId
