# MySQL 完整规范

## 建表规范

### 表级别
- 引擎：InnoDB
- 字符集：utf8mb4
- 排序：utf8mb4_general_ci
- 表名：t_业务前缀_实体名（snake_case）
- 每表必须有注释

### 字段级别
- 所有字段 NOT NULL + 默认值
- 主键：BIGINT UNSIGNED（雪花算法）
- 金额：BIGINT（单位：分）
- 状态/类型：TINYINT
- 短文本：VARCHAR（按需定长）
- 长文本：TEXT（独立拆表）
- 时间：DATETIME
- 布尔：TINYINT(1)
- 每字段必须有注释

### 必备字段
- id, created_time, updated_time, created_by, updated_by, deleted, version

## 索引规范

### 命名
- 主键：PRIMARY
- 唯一索引：uk_表名_字段
- 普通索引：idx_表名_字段

### 规则
- WHERE 条件字段必须有索引
- 遵循最左前缀原则
- 单表索引 ≤ 5 个
- 优先覆盖索引
- 低基数字段不单独建索引
- 索引字段顺序：等值查询在前，范围查询在后

## 查询规范
- 禁止 SELECT *
- JOIN ≤ 3 表
- ORDER BY 有索引
- LIMIT 深分页用游标
- WHERE 不对索引列用函数
- 不隐式类型转换

## 事务规范
- 范围最小化
- 内部禁止远程调用
- 长事务 > 1s 必须优化
- 乐观锁用 version 字段

## DDL 变更规范
- 使用 online DDL 或 pt-osc
- 低峰期执行
- 先加后删的兼容顺序
- 必须有回滚脚本

## 数据生命周期
- 超过保留期的数据归档
- 归档策略提前设计
- 定期清理无效数据
- 大表分区或分表
