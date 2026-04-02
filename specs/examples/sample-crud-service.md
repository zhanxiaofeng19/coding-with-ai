# 示例：标准 CRUD 服务

> 以"会员查询"为例，展示从 Entrance 到 Repository 的完整分层实现。

## Entrance (Controller)

```java
@RestController
@RequestMapping("/api/v1/members")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @GetMapping("/{memberId}")
    public BaseResult<MemberDetailVO> getMemberDetail(
            @PathVariable("memberId") Long memberId) {
        return BaseResult.success(memberService.getMemberDetail(memberId));
    }

    @PostMapping("/page")
    public BaseResult<BasePageVO<MemberListVO>> pageMembers(
            @RequestBody @Valid MemberPageReqDTO reqDTO) {
        return BaseResult.success(memberService.pageMembers(reqDTO));
    }

    @PostMapping
    public BaseResult<Long> createMember(
            @RequestBody @Valid CreateMemberReqDTO reqDTO) {
        return BaseResult.success(memberService.createMember(reqDTO));
    }
}
```

## Service

```java
public interface MemberService {
    MemberDetailVO getMemberDetail(Long memberId);
    BasePageVO<MemberListVO> pageMembers(MemberPageReqDTO reqDTO);
    Long createMember(CreateMemberReqDTO reqDTO);
}
```

```java
@Service
@RequiredArgsConstructor
@Slf4j
public class MemberServiceImpl implements MemberService {

    private final MemberRepository memberRepository;
    private final HeyteaCache heyteaCache;
    private final HeyteaUidGenerator uidGenerator;

    private static final String CACHE_KEY_PREFIX = "member:detail:str:";
    private static final long CACHE_TTL_SECONDS = 600;

    @Override
    public MemberDetailVO getMemberDetail(Long memberId) {
        log.info("getMemberDetail, memberId={}", memberId);

        String cacheKey = CACHE_KEY_PREFIX + memberId;
        MemberDetailVO cached = heyteaCache.get(cacheKey, MemberDetailVO.class);
        if (cached != null) {
            return cached;
        }

        MemberEntity entity = memberRepository.getById(memberId);
        if (entity == null) {
            throw new BizException(BizErrorEnum.MEMBER_NOT_FOUND);
        }

        MemberDetailVO result = MemberConverter.toDetailVO(entity);

        long ttl = CACHE_TTL_SECONDS + ThreadLocalRandom.current().nextLong(60);
        heyteaCache.set(cacheKey, result, ttl, TimeUnit.SECONDS);

        return result;
    }

    @Override
    public BasePageVO<MemberListVO> pageMembers(MemberPageReqDTO reqDTO) {
        log.info("pageMembers, level={}, page={}/{}", 
                reqDTO.getLevel(), reqDTO.getPageNum(), reqDTO.getPageSize());

        IPage<MemberEntity> page = memberRepository.pageByCondition(reqDTO);

        List<MemberListVO> voList = page.getRecords().stream()
                .map(MemberConverter::toListVO)
                .collect(Collectors.toList());

        BasePageVO<MemberListVO> result = new BasePageVO<>();
        result.setList(voList);
        result.setTotal(page.getTotal());
        result.setPageNum(reqDTO.getPageNum());
        result.setPageSize(reqDTO.getPageSize());
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long createMember(CreateMemberReqDTO reqDTO) {
        log.info("createMember, userId={}", reqDTO.getUserId());

        MemberEntity existing = memberRepository.getByUserId(reqDTO.getUserId());
        if (existing != null) {
            log.warn("member already exists, userId={}, memberId={}", 
                    reqDTO.getUserId(), existing.getId());
            return existing.getId();
        }

        Long memberId = Long.parseLong(uidGenerator.generateUid());
        MemberEntity entity = MemberConverter.toEntity(reqDTO, memberId);
        memberRepository.save(entity);

        log.info("createMember success, memberId={}", memberId);
        return memberId;
    }
}
```

## Infrastructure (Repository)

```java
@Repository
@RequiredArgsConstructor
public class MemberRepository {

    private final MemberMapper memberMapper;

    public MemberEntity getById(Long memberId) {
        return memberMapper.selectById(memberId);
    }

    public MemberEntity getByUserId(Long userId) {
        return memberMapper.selectOne(
                new LambdaQueryWrapper<MemberEntity>()
                        .eq(MemberEntity::getUserId, userId)
                        .eq(MemberEntity::getDeleted, 0));
    }

    public IPage<MemberEntity> pageByCondition(MemberPageReqDTO reqDTO) {
        return memberMapper.selectPage(
                new Page<>(reqDTO.getPageNum(), reqDTO.getPageSize()),
                new LambdaQueryWrapper<MemberEntity>()
                        .eq(reqDTO.getLevel() != null, MemberEntity::getLevel, reqDTO.getLevel())
                        .eq(MemberEntity::getDeleted, 0)
                        .orderByDesc(MemberEntity::getCreatedTime));
    }

    public void save(MemberEntity entity) {
        memberMapper.insert(entity);
    }
}
```

## Infrastructure (Mapper)

```java
@Mapper
public interface MemberMapper extends BaseMapper<MemberEntity> {
}
```

## 关键点

- Entrance（Controller）只做参数校验和协议转换
- Service 编排业务逻辑，管理事务
- Repository 在 Infrastructure 层封装数据访问
- Mapper 继承 MyBatis-Plus BaseMapper
- 使用 BaseResult 统一响应
- 使用 HeyteaCache 操作缓存，TTL 带随机抖动
- 使用 HeyteaUidGenerator 生成分布式 ID
- 使用 BizException + BizErrorEnum 抛业务异常
- 关键入口有日志
- 使用构造器注入
