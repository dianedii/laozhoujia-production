# SESSION CONTEXT · 会话交接文档

> **用途**：重启会话后，先读这个文件，30 秒恢复全部上下文。每次会话结束前更新。
> 最后更新：2026-08-22

## 项目一句话

《老周家》抖音 AI 家庭情景短剧：超写实真人风四口之家（爸磊38/妈晓月36/哥浩宇10/妹思琪7），目标受众为爱看家庭琐事的女性休闲用户。人物资产库已就绪（`../character-assets/`），当前处于 **EP01 视频生成阶段**。

## 已定稿决策（勿再讨论，直接执行）

1. **两套额度体系**：Flow 点数（AI Pro 每月1000，现余1050，网页专用，月底清零）≠ Gemini API key（免费层生图 `limit:0` 已实测确认，API 自动化线停用）。生图=Flow 内 Nano Banana 2（0点），视频=Flow 内 Omni Flash
2. **声音方案A**：台词 100% 剪映后期固定音色配音；视频提示词**不写台词**只写口型动作+环境音。SH01 保留一条原生中文对白 AB 对照版（+25点）供对比
3. **EP01 v2 剧情（泡沫海版）**：立flag→琪琪预言→挤半瓶洗洁精埋雷→宣布完工（泡沫偷涨）→下摇打脸→金句应验→妈递拖把收束。50秒/7镜/全程厨房单场景。片尾字幕「承诺越满，泡泡越多。」
4. 浩浩本集仅画外音「切——」（SH04 第4秒）；琪琪两次拆台是"预言→应验"结构，保留
5. 一致性铁律：每镜必挂 `00-master-front.png` + STYLE_BIBLE 锁定句原样拼接；同框正脸≤2；一镜一事；重roll≤2次
6. production 目录 git 管理（本地仓库，无远端）

## 当前进度

| 事项 | 状态 |
|------|------|
| production 目录+全套文档（README/STYLE_BIBLE/workflow/flow-manual/api-pipeline/voice/credits） | ✅ git `4b22170` |
| EP01 v2 提示词包 SH01~SH07（含配音卡）+ storyboard | ✅ git `239d9f2` |
| API key 实测 | ✅ 免费层 limit:0，API线停用 |
| **3张场景图** | ⚠️ **用户已在 Flow 生成，但还没存进项目** |
| SH01~07 视频生成 | ⬜ 未开始 |
| 剪映后期 | ⬜ 未开始 |

## 用户下一步（重启后第一件事）

1. 把 Flow 里已生成的 3 张场景图下载 → 存入 `production/assets/scenes/` → 改名 `SCENE-kitchen.png` / `SCENE-livingroom.png` / `SCENE-dining.png`（EP01 只用 kitchen）
2. 按 `episodes/EP01-xiwan/prompts/SH01.md` → SH07 顺序逐镜生成视频（Omni Flash/9:16/输出1/时长见各文件），片段改名 `SHxx_v1.mp4` 存 `clips/`
3. 每笔消耗记 `ledger/credits.md`（预算上限 285 点）
4. 全部完成后进入剪映后期：按各 SH 文件末尾配音卡配音（音色定版后填 `docs/voice.md` 表格）→ 大字幕 → 片尾字幕 →「AI 生成」标注

## 下一个会话的我应该做什么

- 用户报告"场景图存好了" → 用 `Get-ChildItem production\assets\scenes` 验证文件名
- 用户报告某镜翻车 → 读对应 SHxx.md 和 notes.md，改提示词（改前先看 STYLE_BIBLE 骨架）
- 用户报告全部片段完成 → 指导剪映后期（workflow.md Step5 + voice.md）
- EP01 收尾后 → 主动提醒：点数月底清零，剩余 ~700 可做 EP02《遥控器最高权力》（客厅场景，浩浩主场），需要时直接产出 EP02 提示词包
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
    ├── ledger/credits.md                # 点数台账(余额1050)
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
- 环境是 win32 + PowerShell，中文输出先 `[Console]::OutputEncoding=[Text.Encoding]::UTF8` 防乱码
