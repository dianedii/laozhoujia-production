# API 备用线 · Gemini API 自动化（当前未启用）

> 状态：⛔ **未启用（已实测确认）**。
> **2026-08-22 实测记录**：调用 `gemini-3.1-flash-image` 返回 HTTP 429，错误体明确：
> `generate_content_free_tier_requests, limit: 0, model: gemini-3.1-flash-image`
> 即 key 处于**免费层且生图模型免费额度为 0**，未绑卡前 API 无法出图。
> 正式生产走 Flow 网页（见 flow-manual.md）。未来绑卡后按下方步骤启用。

## 两套账，别搞混

| 体系 | 用途 | 计费 |
|------|------|------|
| Flow 点数 | Flow 网页生成 | AI Pro 会员每月 1000 点 |
| **Gemini API key** | 代码调用（本目录 scripts） | **独立按量扣钱**，与会员无关 |

## 模型 ID 对照

| 用途 | 模型 ID | 参考价 |
|------|---------|--------|
| 生图（Nano Banana 2） | `gemini-3.1-flash-image` | ≈$0.067/张(1K) |
| 生图（便宜版） | `gemini-3.1-flash-lite-image` | ≈$0.034/张(1K) |
| 视频 Lite / Fast / Quality | `veo-3.1-lite-generate-preview` 等 | $0.05~0.40/秒 |

> 结论：API 生视频比 Flow 点数贵约 2 倍，**视频永远走 Flow**；API 只考虑用于批量生图自动化。

## 启用步骤（绑卡后）

1. https://aistudio.google.com → 设置里开通付费层（绑卡）
2. PowerShell 运行连通测试：
   ```powershell
   .\scripts\test_api.ps1
   ```
   成功 → 在 `episodes/EP01-xiwan/frames/api-test.png` 出图
3. 把本文件状态改为 ✅ 已启用，README 状态表同步更新

## 成本估算（批量生图场景）

- 一集 8 镜首帧图 × 2 版本 = 16 张 ≈ $1.07（NB2 1K）
- 场景图一次性 6 张 ≈ $0.40

## 排错速查

| 报错关键字 | 原因 | 处理 |
|-----------|------|------|
| `billing` / `PERMISSION_DENIED` | 未绑卡 | 去 AI Studio 开通付费层 |
| `429 RESOURCE_EXHAUSTED` | 触发限额 | 等一分钟或降低并发 |
| `404 model not found` | 模型 ID 写错或区域不支持 | 核对模型 ID |
| 返回空 parts | 安全拦截 | 改写提示词（去掉敏感词）重试 |

## 密钥位置

opencode 存放于：`%USERPROFILE%\.local\share\opencode\auth.json` → `.google.key`
`test_api.ps1` 会自动读取，无需手动设置环境变量；**不要把 key 复制进任何文档或代码**。
