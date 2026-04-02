# 特性开关规范

## 使用场景
- 新功能灰度发布
- A/B 测试
- 紧急关闭有问题的功能
- 长期运行的功能开关

## 开关命名
格式：`feature.{模块}.{功能名}.enabled`
示例：`feature.order.newCheckout.enabled`

## 开关类型

| 类型 | 用途 | 生命周期 |
|------|------|---------|
| Release Toggle | 灰度发布 | 短期（全量后删除） |
| Experiment Toggle | A/B 测试 | 短期（实验结束后删除） |
| Ops Toggle | 运维开关 | 长期 |
| Permission Toggle | 权限控制 | 长期 |

## 灰度维度
- 用户 ID 尾号
- 城市/区域
- 渠道（App/H5/小程序）
- 百分比随机
- 白名单

## 实现规范
- 通过配置中心管理（Apollo）
- 开关检查封装为工具方法
- 默认值为关闭（安全侧）
- 降级时自动关闭新功能开关

## 生命周期管理
- 创建时记录：负责人、目的、预计下线时间
- 全量后及时清理 Release Toggle
- 定期检查过期开关（每月）
- 超过 3 个月未清理的开关告警

## 代码示例

```java
if (featureFlag.isEnabled("feature.order.newCheckout.enabled", userId)) {
    // 新逻辑
} else {
    // 旧逻辑
}
```

## 禁止事项
- 禁止嵌套超过 2 层的开关判断
- 禁止在循环中检查开关（缓存结果）
- 禁止用开关替代正常的条件分支
