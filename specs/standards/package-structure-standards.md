# 包结构规范

## 标准包结构

```
com.heytea.{project}
├── entrance              # 适配层（对外接口入口）
│   ├── controller        # RESTful 接口
│   │   └── XxxController
│   ├── scheduler         # 定时任务（XXL-Job）
│   │   └── XxxScheduler
│   └── consumer          # MQ 消费者
│       └── XxxConsumer
├── service               # 应用层（业务编排）
│   ├── XxxService        # 接口
│   └── impl
│       └── XxxServiceImpl  # 实现
├── domain                # 领域层（按模块划分）
│   ├── member            # 会员模块
│   │   ├── entity        # 数据库实体
│   │   ├── dto           # 传输对象
│   │   ├── vo            # 视图对象
│   │   ├── bo            # 业务对象
│   │   └── enums         # 枚举
│   ├── coupon            # 优惠券模块
│   └── product           # 商品模块
└── infrastructure        # 基础设施层
    ├── constant          # 常量
    ├── exceptions        # 异常（BizErrorEnum / SystemErrorEnum）
    ├── config            # 配置类
    ├── utils             # 工具类
    ├── mq                # MQ 配置与生产者
    ├── redis             # Redis 配置
    ├── client            # 外部服务客户端（Feign）
    └── repository        # 数据访问（Mapper + DAO 封装）
```

项目名命名规则：项目名 `manager-member-premium` → 包名 `com.heytea.manager.member.premium`

## 层间依赖规则

```
Entrance → Service → Domain
                   → Infrastructure
```

- 禁止反向依赖
- Entrance 不能直接调用 Infrastructure
- Domain 层保持纯净，不依赖 Spring 框架和 Infrastructure
- 同层之间可调用但注意循环依赖

## 对象流转

```
前端 ←→ VO ←→ Entrance(Controller) ←→ DTO ←→ Service ←→ BO
                                                         ↓
                                              Entity ←→ Infrastructure(Repository) ←→ DB
```

## 包的拆分时机
- Domain 层按业务模块拆分（member/coupon/product）
- 单个包内类超过 20 个 → 考虑进一步拆分
- Infrastructure 按技术组件拆分（mq/redis/client/repository）
