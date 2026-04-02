# MySQL 表设计文档

## 修改历史

| 日期 | 修改人 | 修改内容 |
|------|--------|---------|
| YYYY-MM-DD | 姓名 | 初始版本 |

## 1. 表概述

| 项目 | 内容 |
|------|------|
| 表名 | t_xxx |
| 所属库 | |
| 用途 | |
| 预估数据量 | <!-- 如：日增 10 万行，1 年后约 3600 万行 --> |
| 是否分表 | <!-- 否 / 是（分表键：xxx，分 N 张表） --> |

## 2. 表结构

```sql
CREATE TABLE `t_xxx` (
    `id` bigint unsigned NOT NULL COMMENT '主键',
    
    -- 业务字段
    
    -- 审计字段
    `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `created_by` varchar(64) NOT NULL DEFAULT '' COMMENT '创建人',
    `updated_by` varchar(64) NOT NULL DEFAULT '' COMMENT '更新人',
    `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除 1-已删除',
    `version` int NOT NULL DEFAULT 0 COMMENT '乐观锁版本号',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='表注释';
```

## 3. 字段说明

| 字段名 | 类型 | 默认值 | 说明 | 取值范围/枚举 |
|--------|------|--------|------|-------------|
| id | bigint unsigned | - | 主键（雪花算法） | - |
| | | | | |

## 4. 索引设计

| 索引名 | 类型 | 字段 | 用途（命中场景） |
|--------|------|------|-----------------|
| PRIMARY | 主键 | id | 按 ID 查询 |
| uk_xxx | 唯一索引 | | |
| idx_xxx | 普通索引 | | |

## 5. 核心查询路径

<!-- 列出使用本表的核心查询，说明如何命中索引 -->

| 查询场景 | WHERE 条件 | 命中索引 | 预估扫描行数 |
|---------|-----------|---------|------------|
| | | | |

## 6. 数据量与性能评估

| 维度 | 评估 |
|------|------|
| 日增量 | |
| 1 年后总量 | |
| 单次查询扫描行数 | |
| 是否需要归档 | |
| 归档策略 | <!-- 如：超过 6 个月的数据归档到历史表 --> |

## 7. 变更计划

### DDL 执行方式

<!-- online DDL / pt-osc / gh-ost -->

### 执行时间

<!-- 低峰期：凌晨 2:00 -->

### 回滚 DDL

```sql
-- 回滚脚本
```

## 8. 数据迁移（如需要）

<!-- 描述数据迁移方案和验证方式 -->
