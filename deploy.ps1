# Word Atlas 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/designfuchen/word-atlas/blob/main/docs/deployment.md
# 更新日期：2026-10-29
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

node -e "const a=+process.versions.node.split('.')[0]; if(a<20){console.error('需要 Node.js 20+，当前 '+process.versions.node);process.exit(1)}"
git clone --depth 1 https://github.com/designfuchen/word-atlas.git
Set-Location word-atlas
npm ci
Start-Process -FilePath "npm.cmd" -ArgumentList "run","dev" -WindowStyle Hidden -RedirectStandardOutput word-atlas.log -RedirectStandardError word-atlas.err.log
Write-Host '已启动：http://127.0.0.1:5188'

Write-Host ''
$url = 'http://127.0.0.1:5188'
Write-Host "等待服务启动：$url"
$ready = $false
for ($i = 0; $i -lt 30; $i++) {
  try {
    Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec 3 | Out-Null
    $ready = $true
    break
  } catch {
    Start-Sleep -Seconds 2
  }
}
if (-not $ready) { throw "60 秒内未探测到 $url，请手动打开确认或查看日志" }
Write-Host '服务已就绪'
Write-Host '部署完成：打开 http://127.0.0.1:5188，先定每日计划，再按 FSRS 安排复习'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/designfuchen/word-atlas/blob/main/docs/deployment.md'
