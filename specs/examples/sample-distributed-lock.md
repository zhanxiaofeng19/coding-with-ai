# 示例：分布式锁使用

## Redisson 方式（推荐）

```java
@Component
@RequiredArgsConstructor
@Slf4j
public class StockDeductManager {

    private final RedissonClient redissonClient;
    private final StockMapper stockMapper;

    public boolean deductStock(Long productId, int quantity) {
        String lockKey = "stock:lock:" + productId;
        RLock lock = redissonClient.getLock(lockKey);

        boolean locked = false;
        try {
            // 等待 3s，持有 10s
            locked = lock.tryLock(3, 10, TimeUnit.SECONDS);
            if (!locked) {
                log.warn("acquire lock failed, productId={}", productId);
                throw new BizException(StockErrorCode.LOCK_ACQUIRE_FAILED);
            }

            // 业务逻辑
            StockDO stock = stockMapper.selectByProductId(productId);
            BizAssert.notNull(stock, StockErrorCode.PRODUCT_NOT_FOUND);

            if (stock.getAvailable() < quantity) {
                throw new BizException(StockErrorCode.STOCK_NOT_ENOUGH);
            }

            int affected = stockMapper.deductStock(
                    productId, quantity, stock.getVersion());
            if (affected == 0) {
                throw new BizException(StockErrorCode.CONCURRENT_CONFLICT);
            }

            log.info("deductStock success, productId={}, quantity={}", 
                    productId, quantity);
            return true;

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new SystemException("lock interrupted", e);
        } finally {
            if (locked && lock.isHeldByCurrentThread()) {
                lock.unlock();
            }
        }
    }
}
```

## 原生 Redis 方式

```java
public boolean tryLock(String key, String value, long expireSeconds) {
    Boolean result = redisTemplate.opsForValue()
            .setIfAbsent(key, value, expireSeconds, TimeUnit.SECONDS);
    return Boolean.TRUE.equals(result);
}

public boolean unlock(String key, String expectedValue) {
    String script = "if redis.call('get',KEYS[1]) == ARGV[1] "
            + "then return redis.call('del',KEYS[1]) "
            + "else return 0 end";
    Long result = redisTemplate.execute(
            new DefaultRedisScript<>(script, Long.class),
            List.of(key), expectedValue);
    return Long.valueOf(1L).equals(result);
}
```

## 关键点
- tryLock 设置等待时间，避免无限阻塞
- 锁超时时间 > 业务执行时间（余量 2 倍）
- finally 中释放锁，且校验是否当前线程持有
- 释放时用 Lua 脚本保证原子性（原生方式）
- 结合乐观锁（version）做双重保护
