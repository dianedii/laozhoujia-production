# Workflow · 标准 SOP

> 从「选定脚本」到「发布成片」的完整流程。每一步的产出物和责任人写清楚，照着做即可。
> 文档分工：本文件=流程主线（做什么）；`flow-manual.md`=人工操作 Flow（怎么点）；`flow-automation.md`=AI 自动化数据（映射表/API）；skill `flow-video-generation`=AI 自动化操作方法。

## 总流程图

```
[0 读项目/接手] → [1 选脚本] → [2 写分镜表] → [3 生成场景锁定图] → [4 逐镜生视频] → [4.5 本地拼接demo] → [5 剪映后期] → [6 发布+记账]
    CONTEXT/手册     讨论会HTML    opencode产出      Flow·NB2·0点         Flow·挂参考图          ffmpeg无损拼接        固定音色配音            台账更新
```

---

## Step 0 读项目 / 接手检查（每次会话第一件事）

1. 读 `CONTEXT.md`（会话交接：决策、进度、下一步）
2. 读本文件 + `docs/flow-automation.md`（映射表/余额/单价）
3. 半途接手清单（对照打勾，缺啥补啥）：
   - [ ] `episodes/EPxx/clips/` 已有哪些片段？（`Get-ChildItem` 验证）
   - [ ] `assets/scenes/` 场景图是否已存本地？（空 = 未完成 Step 3 存档，先去 Flow 下载）
   - [ ] 余额核对（flow-automation.md 的 API 端点查）
   - [ ] 换新项目时：先跑附录A 初始化

## Step 1 选脚本

- 来源：`character-assets/AI家庭短片-风格人设讨论会.html` 第 4.5 节选题池（01~10 集）与 4.6 广告集
- 配比要求：约 60% 搞笑 + 40% 温馨/节气；钩子必须在前 3 秒
- 产出：确定集号，建 `episodes/EPxx-主题/` 目录（含 prompts/scenes、frames、clips 子目录）

## Step 2 写分镜表（opencode 完成）

规则：
1. 单集 45–60 秒 = 6–10 个镜头；每镜 4–8 秒
2. **一镜一事**：一个镜头只演一个动作节拍
3. **同框清晰正脸 ≤ 2 人**，第三人背影或画外音
4. 台词全部走后期配音，视频提示词不写台词
5. 每镜标注：出场角色 / 要挂的参考图（查 `character-assets/manifest.json`）/ 模型建议 / 预估点数

产出：`00-storyboard.md` + `prompts/SHxx.md`（提示词按 STYLE_BIBLE 骨架组装）

### 提示词质检清单（进 Flow 前逐条打勾）

- [ ] 人物锁定句从 STYLE_BIBLE 原样粘贴
- [ ] 场景锚定句匹配本镜场景
- [ ] 动作量 ≤ 时长上限（8s 一事）
- [ ] 口型动作有写但无台词内容
- [ ] 负向词在末尾
- [ ] 参考图清单齐（master 必挂）
- [ ] 竖屏 9:16 设置确认

### 生成后双层验收（AI 不能看图，必须人机分工）

- **AI 层（技术参数，每次生成后自动做）**：
  - 模型/时长/比例/输出数量正确（8s=12点、6s=10点）
  - `projectInitialData` 核对挂载的参考图 mediaId 与映射表一致（防挂错角色）
  - 生成状态 `MEDIA_GENERATION_STATUS_SUCCESSFUL`
- **人眼层（画面内容，用户逐镜看）**：
  - 泡沫量/动作幅度够不够戏剧化、手部崩没崩、表情对不对、脸像不像 master
  - 不满意 → 重 roll（同镜 ≤2 次）；仍不行 → 改提示词而不是硬 roll

## Step 3 生成场景锁定图（每系列只做一次）

1. 打开 `prompts/scenes/` 里的场景提示词，在 Flow 用 **Nano Banana 2**（0 点）生成
2. 场景图里可以有生活陈设，但**不要出现角色正脸特写**（避免污染场景基准）
3. 满意的图下载为 `SCENE-xxx.png` 存入 `production/assets/scenes/`
4. **下载存档是硬步骤**——图留在 Flow 项目里不算完成；之后所有生图/生视频都把对应场景图作为参考一并挂上
5. 记录场景图的 mediaId 进 `flow-automation.md` 映射表

## Step 4 逐镜生视频（Flow 网页）

两条路径，按执行者分流：

- **人工操作** → 按 `docs/flow-manual.md` 逐镜执行
- **AI 自动化操作** → 调 skill `flow-video-generation`（操作方法）+ `docs/flow-automation.md`（映射表/API 数据）

共同要点：

1. 项目路径二选一：
   - 复用已有项目（EP01 现状，直接进 `labs.google/fx/zh/tools/flow/project/{projectId}`）
   - 新建 Project：命名 `LZJ-EPxx`（EP02 起），先跑附录A 初始化
2. 上传 Ingredients：该镜角色的 master 图 + 表情图 + 场景图
3. 粘贴提示词 → 选模型 → 竖屏 → 生成
4. 模型选择策略：
   - 默认 **Omni Flash**（支持参考图、时长灵活、性价比最高）
   - 纯氛围空镜可用 Veo Lite 省点数
   - 重 roll 同一镜最多 2 次，仍不满意→改提示词而不是硬 roll
5. 满意片段下载，命名 `SHxx_v版本.mp4` 放进 `clips/`
6. **每次提交后立即用 `projectInitialData` 验证**（workflow 出现+参数正确+mediaId 核对），防白扣点
7. 每镜完成记 `ledger/credits.md`（实测单价：8s=12 / 6s=10）

## Step 4.5 本地拼接 demo 样片（ffmpeg）

> 用途：7 镜全部生成后先拼粗剪，人眼验收节奏与连贯性；配音/字幕仍是剪映后期的事。

1. **先查编码**（决定拼接方式）：
   ```
   ffprobe -v error -select_streams v:0 -show_entries stream=codec_name,width,height,r_frame_rate,pix_fmt -of csv=p=0 SHxx_v1.mp4
   ffprobe -v error -select_streams a:0 -show_entries stream=codec_name,sample_rate,channels -of csv=p=0 SHxx_v1.mp4
   ```
2. **编码全一致**（视频同 codec/分辨率/帧率 + 音频同 codec/采样率）→ concat demuxer **无损拼接**：
   ```
   (Get-Content clips 片段清单) → list.txt（格式：file '路径'）
   ffmpeg -f concat -safe 0 -i list.txt -c copy clips/demo-EPxx-v0.mp4
   ```
3. **编码不一致** → filter 重编码统一（注意会损失画质，能无损就别走这）：
   ```
   ffmpeg -f concat -safe 0 -i list.txt -vf "scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2" -r 24 -c:v libx264 -crf 18 -c:a aac -ar 48000 clips/demo-EPxx-v0.mp4
   ```
4. **验证产出**：ffprobe 查时长≈分镜总时长、分辨率 720x1280、24fps
5. 命名：`demo-EPxx-v0.mp4`（v0 = 未配音粗剪），与成片 `EPxx-主题_日期_final.mp4` 区分

## Step 5 剪映后期

按顺序：
1. 按 storyboard 顺序排列片段，掐掉废帧
2. **配音**：按每镜配音卡（见 voice.md）用固定音色逐句配音
3. **字幕**：大字号白字黑描边，台词一句一条，位置画面下 1/3
4. BGM 音量压到人声 -12dB 以下；音效保留原生环境音
5. 片头片尾模板 + 右上角「AI 生成」角标
6. 导出 1080P 竖屏，命名 `EPxx-主题_日期_final.mp4`

## Step 6 发布 + 记账

1. 封面：统一模板 = 角色表情特写 + 大字标题（如「包在我身上？」）
2. 文案带话题：#家庭日常 #AI短剧 等；评论区置顶「AI 生成说明」
3. 当天更新 `ledger/credits.md`（本集总消耗）+ `episodes/EPxx/notes.md` 复盘（翻车镜头原因、修正写法）
4. 数据复盘：完播率 / 3 秒跳出 / 关注转化；连续两集差→改开头钩子与封面

## 受众适配铁律（目标：抖音爱看家庭琐事的女性休闲用户）

- 大字幕永远要有；语速慢半拍；包袱直给不绕弯
- 冲突不过夜：单集内和解收场
- 不制造教育焦虑、不低俗、孩子镜头守合规

---

## 附录A 新项目初始化清单（EP02 起，命名 `LZJ-EPxx`）

1. Flow 首页新建 Project，命名 `LZJ-EPxx`
2. 上传角色资产：`character-assets/{角色}/00-master-front.png` + 会用到的表情图（媒体选择器→上传媒体→多选）
3. 上传/生成场景图：本地 `assets/scenes/` 有则传；没有则 Nano Banana 2 生成（Step 3）
4. **重抓 mediaId 映射**：遍历媒体选择器 option 读 `img src`，按文件名+上传时间交叉定位（详见 flow-automation.md「重抓映射」）
5. 更新 `docs/flow-automation.md`：新 projectId + 新映射表 + 新项目名
6. 验证余额充足（查 credits API）
7. 之后逐镜生成按 Step 4

## 附录B 编码检查与拼接命令速查

```powershell
# ffmpeg/ffprobe 路径（winget 安装示例）
$ff = "C:\Users\Diane\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-8.1.1-full_build\bin"

# 1. 查视频流（codec/分辨率/帧率/像素格式）
& $ff\ffprobe.exe -v error -select_streams v:0 -show_entries stream=codec_name,width,height,r_frame_rate,pix_fmt -of csv=p=0 SHxx_v1.mp4

# 2. 查音频流（codec/采样率/声道）
& $ff\ffprobe.exe -v error -select_streams a:0 -show_entries stream=codec_name,sample_rate,channels -of csv=p=0 SHxx_v1.mp4

# 3. 全一致 → 无损拼接
# list.txt 每行：file 'C:/路径/SHxx_v1.mp4'（正斜杠，UTF-8 无 BOM）
ffmpeg -f concat -safe 0 -i list.txt -c copy demo-EPxx-v0.mp4

# 4. 不一致 → 重编码统一（720x1280/24fps/aac48k，画质有损）
ffmpeg -f concat -safe 0 -i list.txt -vf "scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2" -r 24 -c:v libx264 -crf 18 -c:a aac -ar 48000 demo-EPxx-v0.mp4

# 5. 验证产出
& $ff\ffprobe.exe -v error -show_entries format=duration -of csv=p=0 demo-EPxx-v0.mp4
```