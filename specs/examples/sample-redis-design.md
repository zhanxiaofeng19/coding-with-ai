# 示例：Redis Key 设计 — 订单详情缓存

## 1. Key 清单

| Key 模式 | 数据结构 | 用途 | TTL | Value 大小 |
|----------|---------|------|-----|-----------|
| order:detail:str:{orderId} | STRING | 订单详情缓存 | 10min+jitter | ~2KB |
| order:lock:str:{orderId} | STRING | 回源互斥锁 | 10s | ~20B |

## 2. 详细设计

### Key: `order:detail:str:{orderId}`

| 项目 | 内容 |
|------|------|
| 数据结构 | STRING |
| 序列化 | JSON |
| TTL | 600s + random(0, 60)s |
| 数据来源 | t_order 表 |
| 更新时机 | 缓存 miss 时回源写入 |
| 删除时机 | 订单更新时删除 |
| 缓存策略 | Cache Aside |

### Value 示例

```json
{
  "orderId": 1234567890,
  "userId": 100001,
  "status": "PAID",
  "totalAmount": 9900,
  "createdTime": "2026-04-02T10:00:00"
}
```

## 3. 一致性方案

| 数据变更场景 | 缓存操作 | 失败处理 |
|------------|---------|---------|
| 订单创建 | 不写缓存（等首次查询回填） | - |
| 订单更新 | 先更新 DB，再删除缓存 | MQ 重试删除 |
| 订单取消 | 先更新 DB，再删除缓存 | MQ 重试删除 |

## 4. 风险评估

| 风险 | 概率 | 防护措施 |
|------|------|---------|
| 缓存穿透 | 低 | 缓存空值，TTL=60s |
| 缓存击穿 | 中 | 回源加互斥锁 order:lock:str:{orderId} |
| 缓存雪崩 | 低 | TTL 随机抖动 |
| 热点 key | 高促时 | 本地缓存兜底（Caffeine, TTL=5s） |
