# SESSION CONTEXT · 会话交接文档

> **用途**：重启会话后，先读这个文件，30 秒恢复全部上下文。每次会话结束前更新。
> 最后更新：2026-08-26

## 项目一句话

《老周家》抖音 AI 家庭情景短剧：超写实真人风四口之家（爸磊38/妈晓月36/哥浩宇10/妹思琪7），目标受众为爱看家庭琐事的女性休闲用户。人物资产库已就绪（`../character-assets/`）。当前：**EP01 待剪映后期；new_ads 库第一集《打完这局》已沈家化并定稿（v2，`../new_ads/scripts/EP01-打完这局-剧本.md`），全链路迁至 `../new_ads/`（scripts/storyboards/videos + docs 流水线自包含）。**

## 已定稿决策（勿再讨论，直接执行）

1. **两套额度体系**：Flow 点数（AI Pro 每月1000，现余**970**，网页专用，月底清零）≠ Gemini API key（免费层生图 `limit:0` 已实测确认，API 自动化线停用）。生图=Flow 内 Nano Banana 2（0点），视频=Flow 内 Omni Flash。**实测单价：8s=12点、6s=10点**（手册 25/20 已过时）
2. **声音方案A**：台词 100% 剪映后期固定音色配音；视频提示词**不写台词**只写口型动作+环境音。SH01 保留一条原生中文对白 AB 对照版（+25点）供对比
3. **EP01 v2 剧情（泡沫海版）**：立flag→琪琪预言→挤半瓶洗洁精埋雷→宣布完工（泡沫偷涨）→下摇打脸→金句应验→妈递拖把收束。50秒/7镜/全程厨房单场景。片尾字幕「承诺越满，泡泡越多。」
4. 浩浩本集仅画外音「切——」（SH04 第4秒）；琪琪两次拆台是"预言→应验"结构，保留
5. 一致性铁律：每镜必挂 `00-master-front.png` + STYLE_BIBLE 锁定句原样拼接；同框正脸≤2；一镜一事；重roll≤2次
6. production 目录 git 管理；远端 `dianedii/laozhoujia-production`（master）
7. **集数口径（2026-08-26）**：老周家 production 线 EP01 洗碗、EP03 作业打卡；《打完这局》已迁至 new_ads 库并沈家化为该库 **EP01**，作业打卡在 new_ads 内顺延为 EP02；character-assets/scripts 的选题编号仅为选题 ID
8. **半自动流水线定型（2026-08-26）**：九段五关卡 SOP 见 `docs/PIPELINE.md`，四件套模板在 `docs/templates/`；创意文档（剧本/分镜）在 character-assets/scripts，生产文档在本仓 episodes；剪映精修环节永久人工

## 当前进度

| 事项 | 状态 |
|------|------|
| production 目录+全套文档（README/STYLE_BIBLE/workflow/flow-manual/api-pipeline/voice/credits） | ✅ git `4b22170` |
| EP01 v2 提示词包 SH01~SH07（含配音卡）+ storyboard | ✅ git `239d9f2` |
| API key 实测 | ✅ 免费层 limit:0，API线停用 |
| **3张场景图** | ⚠️ 存于 Flow 项目（SCENE-KITCHEN 6ac5324b 已用于全部7镜），本地 assets/scenes/ 仍空待下载 |
| SH01~07 视频生成 | ✅ 全部完成，clips/SH01~07_v1.mp4（本次会话共扣80点，1050→970） |
| 流水线 SOP + 四件套模板 + new_ads EP01《打完这局》沈家剧本定稿 + 集数口径统一 | ✅ 2026-08-26 会话完成 |
| EP01 剪映后期 | ⬜ 未开始 |
| new_ads EP01 分镜（待人审 G1 后启动） | ⬜ 未开始 |

## 用户下一步（重启后第一件事）

1. **人审 new_ads EP01《打完这局》剧本**（`../new_ads/scripts/EP01-打完这局-剧本.md`，沈家 v2）→ 通过后在 new_ads 库按 PIPELINE S2 拆分镜（新库 docs/ 已自包含流程文档）
2. 把 Flow 项目「老周一家人-第一集-洗碗」里的 3 张场景图下载 → 存入 `production/assets/scenes/` → 改名 `SCENE-kitchen.png` / `SCENE-livingroom.png` / `SCENE-dining.png`（EP01 只用 kitchen）
3. **逐镜验收 clips/SH01~07_v1.mp4**（AI 无法看画面，只验证了技术参数：8s/6s、9:16、参考图、模型；泡沫量/手指/表情需人眼确认，不满意的重 roll ≤2 次）
4. 全部确认后进入剪映后期：按各 SH 文件末尾配音卡配音（音色定版后填 `docs/voice.md` 表格）→ 大字幕 → 片尾字幕 →「AI 生成」标注
5. 可选：SH01-AB 对照版（+25点）未做

## 下一个会话的我应该做什么

- 用户报告"new_ads EP01 剧本通过/要改" → 通过则走 PIPELINE S2 用模板②拆分镜；要改则先改剧本
- 用户报告"场景图存好了" → 用 `Get-ChildItem production\assets\scenes` 验证文件名
- 用户报告某镜翻车 → 读对应 SHxx.md 和 notes.md，改提示词（改前先看 STYLE_BIBLE 骨架）
- 用户报告全部片段通过验收 → 指导剪映后期（workflow.md Step5 + voice.md）
- new_ads EP01 进 S5 时 → 先用 NB2 出成对手柄道具图（深灰/奶白）+ 厨房场景图，存资产库 `../new_ads/scene/01-shen-home/`
- 写回协议：EP01 完成后把"首集制作复盘"写入知识库 `00-Inbox/`

## 关键路径速查

```
老周一家人/
├── character-assets/                    # 人物资产库(4人×6-7图+LOCK文件+manifest.json) 只读
└── production/                          # 本仓库(git)
    ├── README.md                        # 总览+上手
    ├── CONTEXT.md                       # ← 本文件
    ├── docs/STYLE_BIBLE.md              # 风格宪法(锁定句/负向词/场景锚定句/道具表)
    ├── docs/workflow.md                 # SOP六步
    ├── docs/flow-manual.md              # Flow操作+模型点数表
    ├── docs/api-pipeline.md             # API备用线(停用,已实测)
    ├── docs/voice.md                    # 剪映音色规范
    ├── ledger/credits.md                # 点数台账(余额970，实测单价8s=12/6s=10)
    ├── scripts/test_api.ps1             # API测试(PS1必须UTF-8带BOM!)
    └── episodes/EP01-xiwan/
        ├── 00-storyboard.md             # 7镜总表+配音卡汇总+预算
        ├── prompts/SH01~07.md           # 逐镜提示词
        ├── prompts/scenes/              # 场景图提示词×3
        ├── notes.md                     # 进度+翻车复盘
        ├── frames/ clips/               # 产出物(git忽略)
        └── assets→../../assets/scenes/  # 场景锁定图存 production/assets/scenes/
```

## 技术备忘

- PowerShell 5.1 跑含中文的 .ps1 必须 UTF-8 **带 BOM**，否则乱码解析错误
- git 提交用 `-c user.name="Diane" -c user.email="diane@local"`（仓库无全局身份配置）
- Flow 生成设置三查：模型 Omni Flash / 竖屏 9:16 / 输出数量 1（否则双倍扣点）
- **Flow 选参考图铁律**：同名文件（00-master-front.png 等每角色一张）在媒体选择器里不可按顺序点击，必须先读 option 内 img src 的 mediaId 再选（mediaId→角色映射看 projectInitialData API）
- 提交生成后立即用 `flow.projectInitialData` API 验证 workflow 出现+参数正确；消失未扣点就重提交（SH04/SH07 各遇一次）
- 环境是 win32 + PowerShell，中文输出先 `[Console]::OutputEncoding=[Text.Encoding]::UTF8` 防乱码
