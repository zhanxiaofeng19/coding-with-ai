# 示例：MQ 消费者 — 订单支付成功通知

## 消费逻辑

```java
@Component
@RequiredArgsConstructor
@Slf4j
public class OrderPaidConsumer implements RocketMQListener<OrderPaidMessage> {

    private final FulfillmentService fulfillmentService;
    private final MessageDeduplicator deduplicator;

    @Override
    @RocketMQMessageListener(
            topic = "prod_payment_order_paid",
            consumerGroup = "fulfillment_order_paid_cg",
            maxReconsumeTimes = 5)
    public void onMessage(OrderPaidMessage message) {
        String messageId = message.getMessageId();
        String traceId = message.getTraceId();
        MDC.put("traceId", traceId);

        log.info("received OrderPaid message, messageId={}, orderId={}",
                messageId, message.getData().getOrderId());

        try {
            // 幂等检查
            if (deduplicator.isDuplicate(messageId)) {
                log.warn("duplicate message, skip. messageId={}", messageId);
                return;
            }

            // 业务处理
            fulfillmentService.startFulfillment(message.getData().getOrderId());

            // 标记已消费
            deduplicator.markConsumed(messageId);

            log.info("OrderPaid message consumed, messageId={}", messageId);

        } catch (BizException e) {
            log.error("biz error consuming OrderPaid, messageId={}, code={}, msg={}",
                    messageId, e.getCode(), e.getMessage());
            // 业务异常不重试（如订单状态不对），直接标记消费成功
            deduplicator.markConsumed(messageId);

        } catch (Exception e) {
            log.error("error consuming OrderPaid, messageId={}", messageId, e);
            // 系统异常抛出，触发 MQ 重试
            throw e;

        } finally {
            MDC.remove("traceId");
        }
    }
}
```

## 幂等去重器

```java
@Component
@RequiredArgsConstructor
public class MessageDeduplicator {

    private final RedisHelper redisHelper;
    private static final String KEY_PREFIX = "mq:dedup:";
    private static final long DEDUP_TTL_HOURS = 24;

    public boolean isDuplicate(String messageId) {
        String key = KEY_PREFIX + messageId;
        return redisHelper.exists(key);
    }

    public void markConsumed(String messageId) {
        String key = KEY_PREFIX + messageId;
        redisHelper.set(key, "1", DEDUP_TTL_HOURS, TimeUnit.HOURS);
    }
}
```

## 关键点
- traceId 从消息中恢复，保证链路连续
- 幂等基于 messageId 去重（Redis，24h 过期）
- 业务异常（BizException）不重试，标记消费成功
- 系统异常（Exception）抛出触发 MQ 自动重试
- 重试次数上限 5 次，超过进死信队列
