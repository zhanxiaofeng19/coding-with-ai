# Agent 指令入口

> 本文件是业务项目的 Agent 入口。请根据项目情况修改下方内容。

## 项目信息

- 项目名称：<!-- 填写项目名 -->
- 业务领域：<!-- 填写业务领域 -->
- 技术栈：<!-- 填写核心技术栈 -->

## 规范来源

本项目遵循 `.ai-standards/` 下的全部规范。

在编码前，agent 必须：
1. 读取 `.ai-standards/AGENTS.md` 了解完整规范索引
2. 读取 `docs/context/project-profile.md` 了解项目技术栈
3. 读取 `docs/context/domain-model.md` 了解领域模型
4. 读取 `docs/context/glossary.md` 了解业务术语

## 项目专属规则

<!-- 在此添加项目级别的特殊规则，会覆盖通用规范中的对应部分 -->

### 示例

```
- 本项目使用 MyBatis-Plus，Mapper 继承 BaseMapper<T>
- 本项目使用 company-starter-redis，Redis 操作通过 RedisHelper 进行
- 本项目的错误码前缀为 20（订单模块）
- 本项目使用 XXL-Job 做定时任务，Job 类继承 IJobHandler
```

## 模板覆盖

如果本项目有不同于通用规范的模板，放在 `docs/templates/` 下，优先于 `.ai-standards/specs/templates/`。

## 输出语言

- 所有面向用户的输出使用中文
- 代码注释使用英文
- Commit Message 使用英文
- 设计文档使用中文
