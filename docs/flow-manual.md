# Google Flow 操作手册

> 入口：https://labs.google/fx/zh/tools/flow （Google 账号登录，需 AI Pro 订阅）
> 本手册只写《老周家》管线用到的功能。

## 点数规则（重要）

- AI Pro 每月 **1,000 点**（当前余额见 `ledger/credits.md`），**每月清零不累积**
- 一次请求可能生成 2 条视频 = 扣双倍；生成前在设置里确认输出数量
- 订阅用户 1080p 画质提升 **0 点**，随手点

## 模型 × 点数 × 能力对照表

| 模型 | 时长 | 点数/条 | 参考图转视频 | 首帧转视频 | 备注 |
|------|------|---------|--------------|-----------|------|
| **Omni Flash** ★主力 | 4/6/8/10s | 实测 **8s=12 / 6s=10**（旧价 15/20/25/30 已过时） | ✅ 支持角色+音频参考 | ✅ | 全能型，本管线默认 |
| Veo 3.1 Lite | 4/6/8s | 10 | ✅ 仅8s | ✅ | 最便宜；**唯一能延长视频**的模型 |
| Veo 3.1 Fast | 4/6/8s | 20 | ✅ 仅8s | ✅ | 备用 |
| Veo 3.1 Quality | 仅8s | 100 | ❌ 不支持参考图！ | ✅ | 只给关键镜头定稿用 |
| Nano Banana 2（生图） | — | **0** | — | — | 场景图/首帧图全靠它 |

## 标准操作：生成一镜视频

1. 登录 Flow → 项目路径二选一：
   - **复用已有项目**（推荐，参考图都在）：进 `labs.google/fx/zh/tools/flow/project/{projectId}`（EP01 的 projectId 见 `flow-automation.md`）
   - **新建 Project**（EP02 起）：命名 `LZJ-EPxx`，先按 `workflow.md` 附录A 上传角色资产+场景图+重抓映射
2. 提示词输入框旁设置确认三件事：**模型=Omni Flash / 竖屏 9:16 / 输出数量=1**（x2+ 双倍扣点）
3. 上传参考图（Ingredients / 帧）：
   - 该镜出场角色的 `00-master-front.png` **必挂**
   - 加对应表情图增强情绪
   - 加场景锁定图 `SCENE-xxx.png`
   - ⚠️ 同名文件（00-master-front.png 等）每角色一张，AI 自动化选图须按 `flow-automation.md` 的 mediaId 法，禁止按顺序点
4. 从 `prompts/SHxx.md` 复制英文提示词整段粘贴
5. 选时长（与提示词文件标注一致；实测单价 8s=12 / 6s=10）
6. 生成 → 不满意重 roll（同镜 ≤2 次）→ 满意后下载
7. 文件命名 `SHxx_v版本.mp4`，存入该集 `clips/`
8. **立刻记台账**；AI 自动化操作时提交后立即用 `projectInitialData` 验证（防白扣点，见 flow-automation.md）

## 标准操作：生成场景锁定图（0 点）

1. 同 Project 里切生图模型 Nano Banana 2
2. 挂该场景相关的生活道具参考（可选）
3. 粘贴 `prompts/scenes/SCENE-xxx.md` 的提示词 → 生成
4. 满意图下载为 `SCENE-xxx.png` 存 `production/assets/scenes/`

## 常见问题

| 症状 | 处理 |
|------|------|
| 脸不像 master 图 | 确认挂了 master；提示词人物锁定句是否被改动；减少同框人数 |
| 多人同框脸串了 | 降到 2 人；或第三人改背影/画外音 |
| 动作没做完 | 动作量超时长上限，删减到一事 |
| 出现文字/水印画面 | 负向词丢了，补上再 roll |
| 手指崩坏 | 重 roll；连续崩则改动作避开手部特写 |
| 点数扣了但没出片 | 等 5 分钟刷新；仍无→截图记录到 notes.md，找 Google 扣款申诉 |
| 提交后 workflow 消失且未扣点 | 前端回滚偶发；用 `flow.projectInitialData` API 验证，消失就重提交 |
| 参考图挂错角色 | 同名文件（00-master-front.png 等）每角色一张，选择器里**不能按顺序点**；先读 option img src 的 mediaId 确认再选 |

## 点数策略

- EP 单集预算 ≈ 300 点（8 镜 Omni Flash + 重 roll 余量）
- Quality(100点) 只用于封面级关键镜头且不支持参考图——默认不用
- 月底前清余额：够就多拍一集，不够就把剩余留给下一月第一天集中用
