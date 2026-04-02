# 错误码分配规范

## 错误码格式

`应用领域(1位) + 应用标识(3位) + 错误类型(1位) + 预留位(1位) + 错误码(3位)`

```
示例: 5_660_1_0_001

[5]   [660]   [1]    [0]   [001]
 ↑      ↑      ↑      ↑      ↑
 应     应     错     预     错
 用     用     误     留     误
 领     标     类     位     码
 域     识     型    (1位)  (3位)
(1位)  (3位)  (1位)
```

### 应用领域

| 编号 | 领域 |
|------|------|
| 5 | 会员 |
| 其他 | 按业务扩展分配 |

### 应用标识
- 对应 Apollo 项目 ID（3位数字）
- 每个独立部署的应用有唯一标识
- 示例：660

### 错误类型

| 编号 | 类型 | 说明 |
|------|------|------|
| 0 | 系统错误 | 系统内部异常，不暴露详情给用户 |
| 1~9 | 业务错误 | 业务规则校验失败 |

### 错误码
- 范围：000~999
- 每个应用内唯一
- 按功能模块分段分配

## 异常类定义

### 系统异常

```java
// infrastructure/exceptions/SystemErrorEnum.java
public enum SystemErrorEnum implements ErrorCode {
    SYSTEM_ERROR("56600001", "系统繁忙，请稍后重试"),
    REMOTE_CALL_FAILED("56600002", "服务调用失败"),
    DB_ERROR("56600003", "数据库异常");
}
```

### 业务异常

```java
// infrastructure/exceptions/BizErrorEnum.java
public enum BizErrorEnum implements ErrorCode {
    MEMBER_NOT_FOUND("56610001", "会员不存在"),
    MEMBER_ALREADY_EXISTS("56610002", "会员已存在"),
    POINTS_NOT_ENOUGH("56610003", "积分不足"),
    COUPON_EXPIRED("56610004", "优惠券已过期"),
    COUPON_ALREADY_USED("56610005", "优惠券已使用");
}
```

## 管理规则

- 系统级异常统一定义在 `SystemErrorEnum.java`
- 业务异常统一定义在 `BizErrorEnum.java`
- 新增错误码必须在枚举中注册
- 错误码一旦发布不可变更含义
- 废弃错误码标记 @Deprecated 但不删除
- 抛出异常统一使用：`throw new BizException(BizErrorEnum.MEMBER_NOT_FOUND)`
