# test_api.ps1 — Gemini API 连通性测试（备用线）
# 用途: 验证 opencode 里配置的 Google API key 能否真实调用 Nano Banana 2 生图
# 用法: .\scripts\test_api.ps1
# 结果: 成功 → episodes/EP01-xiwan/frames/api-test.png
#       失败 → 打印诊断（未绑卡时预期报 billing 错误，属正常）
$ErrorActionPreference = "Stop"

$authPath = Join-Path $env:USERPROFILE ".local\share\opencode\auth.json"
if (-not (Test-Path $authPath)) { Write-Host "[X] 找不到 auth.json: $authPath"; exit 1 }
$auth = Get-Content $authPath -Raw | ConvertFrom-Json
$key = $auth.google.key
if (-not $key) { Write-Host "[X] auth.json 中无 google provider key"; exit 1 }
Write-Host "[OK] 已读取 key（***$($key.Substring([Math]::Max(0,$key.Length-4)))）"

$model = "gemini-3.1-flash-image"
$outFile = Join-Path $PSScriptRoot "..\episodes\EP01-xiwan\frames\api-test.png"
New-Item -ItemType Directory -Force -Path (Split-Path $outFile) | Out-Null

$prompt = @"
Photorealistic Chinese man age 38, square-round face, thick eyebrows, inner double eyelids, warm wheat skin, light stubble on jaw, short side-part hair slightly thinning on crown, dark gray crew-neck home t-shirt, mechanical wristwatch on left wrist. He stands in a modern Chinese apartment kitchen after dinner, hands on hips, looking proudly at a sink piled with dirty dishes, warm beige walls, light wood cabinets, warm ceiling lamp, shallow depth of field, low saturation, Sony camera look, natural skin pores, not cartoon not 3D.
"@

$body = @{
    contents         = @(@{ parts = @(@{ text = $prompt }) })
    generationConfig = @{
        responseModalities = @("TEXT", "IMAGE")
        imageConfig        = @{ aspectRatio = "16:9" }
    }
} | ConvertTo-Json -Depth 10

$uri = "https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent"
Write-Host "[..] 正在调用 $model ..."
try {
    $r = Invoke-RestMethod -Method Post -Uri "$uri`?key=$key" -ContentType "application/json; charset=utf-8" -Body $body -TimeoutSec 180
    $part = $r.candidates[0].content.parts | Where-Object { $_.inlineData } | Select-Object -First 1
    if ($part) {
        [IO.File]::WriteAllBytes($outFile, [Convert]::FromBase64String($part.inlineData.data))
        Write-Host "[OK] 生图成功 → $outFile"
        Write-Host "[OK] 结论: 该 key 已绑卡可计费，API 自动化线可启用（更新 docs/api-pipeline.md 状态）"
    } else {
        Write-Host "[!] 调用成功但返回无图片 parts（可能被安全拦截），原始响应:"
        $r | ConvertTo-Json -Depth 8 | Out-Host
    }
} catch {
    Write-Host "[X] 调用失败: $($_.Exception.Message)"
    if ($_.ErrorDetails -and $_.ErrorDetails.Message) { Write-Host $_.ErrorDetails.Message }
    if ($_.Exception.Message -match "billing|permission|PERMISSION_DENIED|quota") {
        Write-Host "[结论] 未绑卡/无付费层 —— 与预期一致。API 线保持停用，生图走 Flow·Nano Banana 2（0点）。"
    }
}
