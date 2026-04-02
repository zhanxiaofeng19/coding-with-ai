# Redis 完整规范

## Key 设计
- 格式：{服务}:{业务域}:{类型}:{标识}
- 全小写，冒号分隔
- 总长 ≤ 128 字节
- 禁止特殊字符

## 数据结构选择
- KV：STRING
- 对象部分字段：HASH
- 列表：LIST
- 去重集合：SET
- 排行榜：ZSET
- 计数器：INCR
- 位图：BITMAP

## TTL 规范
- 所有缓存必须设 TTL
- TTL + 随机抖动防雪崩
- 热点数据：5~30min
- 冷数据：1~24h
- 禁止不过期的缓存 key

## 序列化
- 推荐 JSON
- 高性能用 Protobuf
- 禁止 Java 原生序列化
- 单 value ≤ 10KB

## 缓存安全
- 穿透：缓存空值 + 布隆过滤器
- 击穿：互斥锁 + 逻辑过期
- 雪崩：TTL 抖动 + 多级缓存
- 一致性：Cache Aside + 延迟双删

## 分布式锁
- SET NX EX 原子操作
- 超时 > 业务耗时 2 倍
- finally 释放
- value 校验防误释放

## 运行规范
- 禁止 KEYS *
- 大 key 用 UNLINK
- O(N) 命令评估 N 值
- 禁止 FLUSHALL/FLUSHDB
- 慢日志监控
