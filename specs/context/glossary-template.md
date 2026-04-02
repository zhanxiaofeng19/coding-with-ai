# 领域词汇表

> 统一业务术语与代码命名的映射关系，确保 agent 生成的代码、注释、文档使用一致的业务语言。

## 使用说明

- agent 在生成代码时，变量名/类名/方法名必须使用本词汇表中定义的英文命名
- agent 在生成注释和文档时，使用本词汇表中的中文术语
- 遇到词汇表中未定义的术语，先向用户确认后再补充

## 用户会员域

| 中文术语 | 英文 | 代码命名 | 说明 |
|---------|------|---------|------|
| 主用户 | Main User | userMain | 系统主账户，唯一标识用户身份 |
| 渠道用户 | OAuth User | oauthUser | 第三方渠道授权用户（微信/支付宝等） |
| 会员 | Member | member | 注册用户的会员身份 |
| 付费会员 | Premium Member | premiumMember | 付费订阅的高级会员 |
| 学生会员 | Student Member | studentMember | 学生认证会员 |
| 星球会员 | Star Member | starMember | 星球等级会员 |
| 灵感经验值 | Inspiration EXP | inspirationExp | 用户行为积累的经验值 |
| 积分 | Points | points | 用户可消费的积分 |
| 权益 | Benefit | benefit | 会员享有的权益项 |
| 特权 | Privilege | privilege | 会员专属特权 |
| 会员等级 | Member Level | memberLevel | 会员等级体系 |

## 营销活动域

| 中文术语 | 英文 | 代码命名 | 说明 |
|---------|------|---------|------|
| 优惠券 | Coupon | coupon | 优惠凭证 |
| 活动 | Campaign | campaign | 营销活动 |
| 抽奖 | Lottery | lottery | 抽奖活动 |
| 折扣 | Discount | discount | 折扣优惠 |
| 领券 | Claim Coupon | claimCoupon | 用户领取优惠券 |
| 核销 | Redeem | redeem | 优惠券使用/核销 |

## 商品菜单域

| 中文术语 | 英文 | 代码命名 | 说明 |
|---------|------|---------|------|
| 门店 | Store | store | 线下门店 |
| 商品 | Product | product | 可售商品 |
| SKU | SKU | sku | 商品最小库存单元 |
| 库存 | Stock / Inventory | stock | 商品可售数量 |
| 菜单 | Menu | menu | 门店商品菜单 |
| 商品分类 | Category | category | 商品分类 |

## 技术术语映射

| 中文术语 | 英文 | 说明 |
|---------|------|------|
| 幂等 | Idempotent | 重复请求产生相同结果 |
| 降级 | Fallback / Degrade | 服务异常时的兜底策略 |
| 熔断 | Circuit Breaker | 依赖异常时的自动断路（Hystrix） |
| 限流 | Rate Limiting | 控制请求速率 |
| 灰度 | Gray Release / Canary | 按用户 ID 尾号逐步放量 |
| 回滚 | Rollback | 恢复到变更前状态 |
| 兜底 | Fallback | 异常时的默认返回 |
| 预热 | Warm-up | 服务启动后逐步接入流量 |
| 打散 | Shard / Scatter | 分散热点到多个节点 |
| 回源 | Cache Miss / Origin Pull | 缓存未命中时查询数据源 |
| 状态扭转 | State Transition | 业务状态的变更（状态机） |
| 任务补偿 | Task Compensation | 失败后的重试/修复机制 |
