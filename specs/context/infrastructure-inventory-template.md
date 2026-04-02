# 基础设施清单

> 详细记录每个基础设施组件的部署信息、连接方式和运维联系人，供 agent 在生成配置和代码时参考。

## 数据库

<!-- Q: 列出所有数据库实例。

示例：
| 实例名 | 用途 | 类型 | 地址 | 读写分离 | 分库分表 |
|--------|------|------|------|---------|---------|
| order-master | 订单主库 | MySQL 8.0 | order-master.db.internal:3306 | 是 | 否 |
| order-slave | 订单从库 | MySQL 8.0 | order-slave.db.internal:3306 | 只读 | 否 |
| user-db | 用户库 | MySQL 8.0 | user.db.internal:3306 | 否 | 否 |
-->

## 缓存

<!-- Q: 列出 Redis 集群信息。

示例：
| 集群名 | 用途 | 模式 | 节点数 | 最大内存 |
|--------|------|------|--------|---------|
| order-cache | 订单缓存 | Cluster | 6 | 32GB |
| session-cache | 会话缓存 | Sentinel | 3 | 8GB |
-->

## 消息队列

<!-- Q: 列出 MQ 集群信息。

示例：
| 集群名 | 用途 | 类型 | Broker 数 |
|--------|------|------|----------|
| trade-mq | 交易消息 | RocketMQ 5.x | 4 |
| log-mq | 日志消息 | Kafka 3.x | 3 |
-->

## 其他中间件

<!-- Q: 列出其他中间件。

示例：
| 组件 | 用途 | 地址 |
|------|------|------|
| Nacos | 注册/配置中心 | nacos.internal:8848 |
| XXL-Job | 任务调度 | xxljob.internal:8080 |
| Elasticsearch | 搜索 | es.internal:9200 |
| MinIO | 对象存储 | minio.internal:9000 |
-->

## 监控与告警

<!-- Q: 列出监控系统信息。

示例：
| 系统 | 用途 | 地址 |
|------|------|------|
| Prometheus | 指标采集 | prometheus.internal:9090 |
| Grafana | 指标展示 | grafana.internal:3000 |
| SkyWalking | 链路追踪 | skywalking.internal:8080 |
| Kibana | 日志查询 | kibana.internal:5601 |
-->

## 运维联系人

<!-- Q: 列出各组件的运维负责人。

示例：
| 组件 | 负责人 | 联系方式 |
|------|--------|---------|
| MySQL | DBA 团队 | dba@company.com |
| Redis | 中间件团队 | middleware@company.com |
| K8s | SRE 团队 | sre@company.com |
-->
