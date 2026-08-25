# Flow 网页自动化操作 · AI 专用手册

> 用途：opencode/AI 直接操作 Flow 网页生成分镜视频时的**数据与快捷方法**。
> 人工操作看 `flow-manual.md`；流程总览看 `workflow.md`；操作方法见 skill `flow-video-generation`。
> 本文件 = 项目专属数据（映射表/端点）+ 通用方法（重抓/上传/拼接）。**换新项目时只换"数据区"**。

---

## 一、EP01 专属数据区（当前项目）

### 项目信息

| 项 | 值 |
|----|----|
| 项目名 | 老周一家人-第一集-洗碗 |
| projectId | `5a53087d-09be-409b-b005-519cdd6eb0d6` |
| 项目主页 URL | `https://labs.google/fx/zh/tools/flow/project/{projectId}` |
| 媒体编辑页 URL | `https://labs.google/fx/zh/tools/flow/project/{projectId}/edit/{workflowId}` |
| 回收站 | `https://labs.google/fx/zh/tools/flow/project/{projectId}/trash` |
| 当前余额 | **970 点**（2026-08-24 实测；API 查询见下方） |

### mediaId → 角色映射表（本项目内稳定，删了重传会变）

> mediaId 出现在媒体选择器 option 的 `img src` 里（`media.getMediaUrlRedirect?name={mediaId}`），以及生成请求的 `videoGenerationImageInputs[].mediaId`。

| mediaId | 角色/用途 | 备注 |
|---------|-----------|------|
| `248a1e62-0854-40df-bb1e-180359b7a88b` | SCENE-KITCHEN | 本集唯一场景图，7 镜全挂 |
| `083ae134-0239-45d2-99b1-9b48f9d5dfb4` | 磊 00-master-front | |
| `4e997f65-55c7-4608-a03c-bd4eb93158b8` | 磊 02-front-embarrassed | |
| `f1bc781f-aab1-4e2c-a83c-793f45695340` | 磊 01-front-confident | |
| `d0639553-f655-4649-ad0b-a6558e7dd2ba` | 晓月 00-master-front | |
| `367071b5-bcec-4985-af7f-48fd40e28cc8` | 晓月 03-front-gentle | |
| `1b7677db-9748-4da6-b737-95aced9925e8` | 琪琪 00-master-front | ⚠️ 与磊/晓月的 master 同名，选图铁律见下 |
| `41f96bda-689b-43c9-a6a8-79e240493b45` | 琪琪 01-front-knowing-smile | |
| `e475bbf3-1298-488b-b177-aa3867abe7ca` | 琪琪 02-front-with-bunny | |
| `b06729ee-2911-4923-a3c5-f67e870e8ecd` | 磊 00-master-front（旧上传） | 与 083ae134 同图，建议统一用 083ae134 |

### 本集 7 镜生成记录（workflowId）

| 镜 | workflowId | 时长 | 状态 |
|----|-----------|------|------|
| SH01 | `cef7e312-64bf-4f1e-84a0-aedb8208d5d6` | 8s | ✅ 用户手动生成 |
| SH02 | `38ce23b9-87bf-4eee-a8d8-458df9c8cf14` | 6s | ✅ 用户手动生成 |
| SH03 | `0a612c23-ade0-4483-896b-d0636f66900f` | 8s | ✅ |
| SH04 | `9c31cb66-f208-4a99-9840-455956914d86` | 6s | ✅ |
| SH05 | `bcc61f71-c522-4805-9178-be6f9f81147e` | 8s | ✅ |
| SH06 | `0cfc0254-e2ef-4658-8713-264f34768161` | 6s | ✅ |
| SH07 | `7e57b041-edc1-4b57-9a1c-e2b7960fc2ee` | 8s | ✅ |

> 已废弃：`8856042f`（旧版疯狂洗碗测试）、`7047020e`（v1 偷吃虾）、`a78e5200`/`a1d04dca`（SH07 挂错参考图已删）。

### 实测单价（2026-08-24，覆盖手册旧价）

| 模型 | 时长 | 点数 |
|------|------|------|
| Omni Flash | 8s | **12** |
| Omni Flash | 6s | **10** |
| Nano Banana 2（生图） | — | 0 |

---

## 二、通用方法区（换项目不变）

### API 端点（在 Flow 页面上下文内 fetch 有效，自带 OAuth 会话）

| 用途 | 端点 |
|------|------|
| 项目全量数据（workflows+media+映射） | `GET /fx/api/trpc/flow.projectInitialData?input={"json":{"projectId":"{projectId}"}}` |
| 余额 | `GET https://aisandbox-pa.googleapis.com/v1/credits?key={WEB_CLIENT_KEY}`（页面内调用有效，外部裸调 401） |

> `{WEB_CLIENT_KEY}` = Google Flow 官网页面自带的公开 web client key（非账号凭证）：在 Flow 页面打开浏览器 DevTools → Network → 过滤 `credits` 即可看到，随官方前端更新可能变化。
| 媒体预览图 | `GET /fx/api/trpc/media.getMediaUrlRedirect?name={mediaId}` |

### 提交后验证铁律（防白扣点）

每次点「创建」后立即：
1. `projectInitialData` 拉取，确认新 workflow 出现（带 batchId）且参数正确：
   - `videoModelControlInput.videoModelName` = `abra_r2v_{时长}`（8s/6s）
   - `videoGenerationMode` = `VIDEO_GENERATION_MODE_REFERENCE_TO_VIDEO`
   - `videoAspectRatio` = `VIDEO_ASPECT_RATIO_PORTRAIT`
   - `videoGenerationImageInputs` 里 `IMAGE_USAGE_TYPE_REFERENCE_IMAGE` 的 mediaId 与映射表核对
2. 若 workflow 凭空消失且余额未动 → 前端回滚，**重提交**（EP01 遇 2 次）
3. 完成后查 `mediaStatus.mediaGenerationStatus` = `MEDIA_GENERATION_STATUS_SUCCESSFUL`

### 选图铁律（SH07 白扣 24 点的教训）

多个角色共享同名文件（`00-master-front.png` 等），**禁止按列表顺序 nth() 点击**。必须：
1. 打开媒体选择器后，遍历 `[role="option"]`，读每个 option 内首个 `img` 的 `src`
2. 取 `name=` 后的 mediaId，与映射表比对命中再点击
3. 上传新文件后新 mediaId 出现在列表顶部——上传的角色资产务必记录新 mediaId 回映射表

### 重抓映射（换项目/删图后必做）

1. 打开项目 → 点「add_2 创建」开媒体选择器
2. JS 遍历 option 读 `img src` + 文本，得到 mediaId→文件名列表
3. 用 `projectInitialData` 的 workflows `displayName` + `createTime` 交叉定位（同名文件按上传时间区分角色）
4. 更新本文件数据区

### 上传角色资产到新项目

1. 媒体选择器 →「上传媒体」→ 文件选择器多选本地 `character-assets/{角色}/` 的图
2. 上传后 5 秒内新 option 在列表顶部；逐一点击加入提示前先按选图铁律核对 mediaId

---

## 三、新项目初始化（EP02 及以后，命名 `LZJ-EPxx`）

> 按 workflow.md 附录A 执行：新建 Flow Project → 上传角色资产+场景图 → 重抓映射 → 替换本文件数据区 → 验证余额。

1. Flow 首页新建 Project，命名 `LZJ-EP02`（或按集号）
2. 上传：4 个角色全套 `character-assets/*/00-master-front.png` + 会用到的表情图 + 场景图 `SCENE-xxx`（若本地 `assets/scenes/` 有则传本地，没有则用 Nano Banana 2 生成）
3. 重抓映射 → 替换第一节表格
4. 记下新 projectId → 更新本文件
5. 检查余额充足后再开始逐镜生成