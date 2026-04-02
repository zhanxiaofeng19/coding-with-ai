# 示例：异常处理与降级

## 全局异常处理器

```java
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(BizException.class)
    public BaseResult<Void> handleBizException(BizException e) {
        log.warn("biz exception, code={}, msg={}", e.getCode(), e.getMessage());
        return BaseResult.fail(e.getCode(), e.getMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public BaseResult<Void> handleValidation(MethodArgumentNotValidException e) {
        String message = e.getBindingResult().getFieldErrors().stream()
                .map(f -> f.getField() + ": " + f.getDefaultMessage())
                .collect(Collectors.joining("; "));
        log.warn("param validation failed: {}", message);
        return BaseResult.fail(SystemErrorEnum.PARAM_ERROR.getCode(), message);
    }

    @ExceptionHandler(Exception.class)
    public BaseResult<Void> handleException(Exception e) {
        log.error("unexpected exception", e);
        return BaseResult.fail(
                SystemErrorEnum.SYSTEM_ERROR.getCode(),
                SystemErrorEnum.SYSTEM_ERROR.getMessage());
    }
}
```

## 降级示例：优惠券服务（Hystrix）

```java
@Component
@RequiredArgsConstructor
@Slf4j
public class CouponClient {

    private final CouponFeignClient couponFeignClient;

    @HystrixCommand(
            fallbackMethod = "verifyFallback",
            commandProperties = {
                @HystrixProperty(name = "execution.isolation.thread.timeoutInMilliseconds", value = "1000"),
                @HystrixProperty(name = "circuitBreaker.requestVolumeThreshold", value = "20"),
                @HystrixProperty(name = "circuitBreaker.errorThresholdPercentage", value = "50")
            })
    public CouponResult verifyCoupon(Long userId, Long couponId, Long amount) {
        return couponFeignClient.verify(userId, couponId, amount);
    }

    public CouponResult verifyFallback(Long userId, Long couponId, Long amount, 
                                        Throwable t) {
        log.warn("coupon service fallback, userId={}, couponId={}, reason={}",
                userId, couponId, t.getMessage());
        return CouponResult.skip("优惠券服务暂不可用，已跳过优惠");
    }
}
```

## Service 中的降级使用

```java
@Service
@RequiredArgsConstructor
@Slf4j
public class OrderServiceImpl implements OrderService {

    private final CouponClient couponClient;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long createOrder(CreateOrderReqDTO reqDTO) {
        // ...其他逻辑...

        // 优惠券验证（非核心依赖，允许降级）
        long discountAmount = 0;
        if (reqDTO.getCouponId() != null) {
            CouponResult couponResult = couponClient.verifyCoupon(
                    reqDTO.getUserId(), reqDTO.getCouponId(), totalAmount);
            if (couponResult.isAvailable()) {
                discountAmount = couponResult.getDiscountAmount();
            } else {
                log.info("coupon skipped, reason={}", couponResult.getReason());
            }
        }

        // ...继续创建订单...
    }
}
```

## 关键点

- BizException 对应业务异常（WARN 级别），用 BizErrorEnum 定义错误码
- SystemException 对应系统异常（ERROR 级别），用 SystemErrorEnum 定义错误码
- 全局异常处理器兜底，使用 BaseResult 统一响应格式
- 非核心依赖通过 Hystrix 熔断降级
- 外部服务调用封装在 infrastructure/client 层
- 降级行为有日志记录原因和影响
- 降级结果对用户友好（跳过优惠而非报错）
