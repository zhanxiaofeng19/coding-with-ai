# 可观测性规范

## 三大支柱

### 日志（Logging）
- 结构化日志（JSON 格式）
- 必含 traceId
- 级别：ERROR > WARN > INFO > DEBUG
- 生产环境默认 INFO
- 脱敏处理

### 指标（Metrics）
- 命名：service_module_metric_unit
- 必须监控：QPS、延迟、错误率
- RED 方法：Rate、Errors、Duration
- USE 方法：Utilization、Saturation、Errors

### 链路追踪（Tracing）
- traceId 全链路透传
- 跨线程透传（MDC + TaskDecorator）
- 跨服务透传（Header）
- 跨 MQ 透传（Message Property）

## 告警分级

| 级别 | 定义 | 响应时间 | 通知方式 |
|------|------|---------|---------|
| P0 | 服务完全不可用 | 立即 | 电话 + 短信 + IM |
| P1 | 核心功能异常 | 15 min | 短信 + IM |
| P2 | 性能劣化 | 1 hour | IM |
| P3 | 预警 | 工作时间 | IM |

## 必须告警的场景
- 核心接口错误率 > 1%
- P99 延迟 > SLO 2 倍
- 连接池/线程池 > 80%
- MQ 积压 > 10 万
- 慢查询 > 1s
- 磁盘 > 85%
- OOM 风险（连续 Full GC）
