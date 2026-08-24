# 《老周家》AI 短剧生产工作区

> 抖音 AI 家庭情景短剧《老周家》的制作目录。人物设定与参考图在隔壁 [`character-assets/`](../character-assets/)（GitHub 资产库），本目录负责**从脚本到成片的全流程生产**。

---

## 一句话管线

```
脚本(讨论会HTML) → 分镜表 → 场景/首帧图(Flow·NB2·0点) → 图生视频(Flow·挂参考图)
     ↑ opencode 产出提示词包                        ↓
发布(抖音) ← 剪辑后期(剪映:配音/字幕/片尾/AI标注) ← clips/ 视频片段
```

## 三线分工

| 工具 | 职责 | 成本 |
|------|------|------|
| **Google Flow**（网页 labs.google/fx） | 生图（Nano Banana 2，0点）、图生视频（Omni Flash 主力） | Flow 点数，每月清零 |
| **opencode** | 分镜提示词包、文档、质检、API 备用线脚本 | 0 |
| **剪映（CapCut）** | 全部台词配音（固定音色）、大字幕、片头片尾、「AI 生成」标注 | 0 |

## 目录结构

```
production/
├── README.md            ← 本文件：总览 + 新人上手
├── docs/
│   ├── STYLE_BIBLE.md   ← 风格宪法！全局提示词模块都在这，改风格只改这里
│   ├── workflow.md      ← 标准 SOP：从选脚本到发布的六步流程
│   ├── flow-manual.md   ← Google Flow 网页操作手册（含模型/点数对照表）
│   ├── api-pipeline.md  ← Gemini API 备用自动化线（当前未绑卡，未启用）
│   └── voice.md         ← 声音规范：剪映固定音色表 + 配音卡说明
├── ledger/
│   └── credits.md       ← 点数台账：每一笔消耗都要记账
├── scripts/
│   └── test_api.ps1     ← API 连通性测试（备用线）
├── assets/
│   └── scenes/          ← 场景锁定图（厨房/客厅/餐桌 master，生成后放这里）
└── episodes/
    └── EP01-xiwan/      ← 每集一个目录，命名 EP编号-主题拼音
        ├── 00-storyboard.md  ← 分镜总表（先看这个）
        ├── notes.md          ← 本集制作记录与翻车复盘
        ├── prompts/
        │   ├── scenes/       ← 场景图提示词
        │   └── SH01~08.md    ← 每镜提示词（直接复制进 Flow）
        ├── frames/           ← 首帧图存档（git 忽略）
        └── clips/            ← 视频片段存档（git 忽略）
```

## 新人上手 10 分钟

1. 读本文 + `docs/workflow.md`，搞懂三线分工
2. 打开 `character-assets/manifest.json` 认识四个角色和他们的资产
3. 读 `docs/STYLE_BIBLE.md`——所有提示词的固定模块来源，**禁止即兴改写**
4. 找到要做的集数 `episodes/EPxx-xxx/00-storyboard.md`，按镜号逐个打开 `prompts/SHxx.md`
5. 照 `docs/flow-manual.md` 在 Flow 里操作；每花一笔点数记入 `ledger/credits.md`
6. 片段下载后按 `SH镜号_v版本.mp4` 命名放进 `clips/`

## 文件命名规范

| 类型 | 格式 | 示例 |
|------|------|------|
| 分镜提示词 | `SH两位镜号.md` | `SH03.md` |
| 场景图 | `SCENE-场景名.png` | `SCENE-kitchen.png` |
| 首帧图 | `SHxx_frame_v版本.png` | `SH03_frame_v2.png` |
| 视频片段 | `SHxx_v版本.mp4` | `SH03_v1.mp4` |
| 成片 | `EPxx-主题_日期_final.mp4` | `EP01-xiwan_0830_final.mp4` |

## 当前状态

> 重启会话先读 [`CONTEXT.md`](CONTEXT.md)（会话交接文档，含全部决策记录和下一步）

| 项目 | 状态 |
|------|------|
| 人物资产库 v1.1.0（爸/妈/哥/妹） | ✅ 就绪（character-assets/） |
| 外婆、全家福资产 | ❌ 未建（不急，低频角色） |
| 场景锁定图 ×3 | ⚠️ 已在 Flow 生成，待存入 assets/scenes/ |
| EP01《洗碗包在我身上》v2 泡沫海版（7镜） | 🔄 提示词包就绪，待 Flow 生成视频 |
| API 自动化生图线 | ⛔ 未绑卡未启用（已实测，见 api-pipeline.md） |

## 硬规则（违反必返工）

1. 每镜视频生成**必挂**该角色的 `00-master-front.png`
2. 提示词中人物锁定句、场景锚定句、负向词从 STYLE_BIBLE 原样复制，禁改
3. 一镜只演一件事；同框清晰正脸 ≤ 2 人
4. 台词一律后期剪映配音，视频提示词里**不写台词**
5. 每笔点数消耗当天记账（ledger/credits.md）
6. 成片必须带「AI 生成」标注；孩子镜头遵守 character-assets 合规规则
