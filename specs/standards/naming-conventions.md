# 命名规范

## 类命名

| 类型 | 规则 | 示例 |
|------|------|------|
| Controller | XxxController | OrderController |
| Service 接口 | XxxService | OrderService |
| Service 实现 | XxxServiceImpl | OrderServiceImpl |
| Manager | XxxManager | PaymentManager |
| Mapper | XxxMapper | OrderMapper |
| Entity/DO | XxxDO | OrderDO |
| DTO 请求 | XxxReqDTO | CreateOrderReqDTO |
| DTO 响应 | XxxRespDTO | OrderDetailRespDTO |
| VO | XxxVO | OrderListVO |
| BO | XxxBO | OrderCalculateBO |
| Config | XxxConfig | RedisConfig |
| Properties | XxxProperties | OssProperties |
| 常量 | XxxConstants | OrderConstants |
| 枚举 | XxxEnum | OrderStatusEnum |
| 异常 | XxxException | OrderNotFoundException |
| Event | XxxEvent | OrderCreatedEvent |
| Listener | XxxListener | OrderCreatedListener |
| Job | XxxJob | OrderTimeoutJob |
| Handler | XxxHandler | PaymentCallbackHandler |
| Factory | XxxFactory | StrategyFactory |
| Strategy | XxxStrategy | DiscountStrategy |
| Converter | XxxConverter | OrderConverter |

## 方法命名

| 场景 | 规则 | 示例 |
|------|------|------|
| 创建 | create / save | createOrder |
| 更新 | update / modify | updateOrderStatus |
| 删除 | delete / remove | deleteOrder |
| 查询单个 | get / find / query | getOrderById |
| 查询列表 | list / find | listOrdersByUserId |
| 查询分页 | page | pageOrders |
| 校验 | check / validate | checkStock |
| 判断 | is / has / can | isExpired |
| 转换 | convert / to / from | convertToVO |
| 计算 | calculate / compute | calculateTotalAmount |

## 变量命名

| 类型 | 规则 | 示例 |
|------|------|------|
| 布尔 | is/has/can 前缀 | isPaid, hasStock |
| 集合 | 复数或 List/Map 后缀 | orders, orderList |
| 数量 | count/num/total 后缀 | orderCount, totalAmount |
| 时间 | time/date/at 后缀 | createdTime, expireAt |
| ID | id/Id 后缀 | userId, orderId |

## 数据库命名
- 表名：t_业务_实体（snake_case）
- 字段：snake_case
- 索引：idx_表名_字段 / uk_表名_字段

## 常量命名
- 全大写 + 下划线
- MAX_RETRY_COUNT
- DEFAULT_PAGE_SIZE
- ORDER_STATUS_CREATED
