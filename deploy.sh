#!/usr/bin/env bash
set -euo pipefail
# Word Atlas 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/designfuchen/word-atlas/blob/main/docs/deployment.md
# 更新日期：2026-10-29
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v node >/dev/null 2>&1 || { echo "需要先安装 Node.js"; exit 1; }

mkdir -p .download
cd .download

node -e "const a=+process.versions.node.split('.')[0]; if(a<20){console.error('需要 Node.js 20+，当前 '+process.versions.node);process.exit(1)}"
git clone --depth 1 https://github.com/designfuchen/word-atlas.git
cd word-atlas
npm ci
nohup npm run dev > word-atlas.log 2>&1 &
echo "已启动：http://127.0.0.1:5188"

echo ""
if command -v curl >/dev/null 2>&1; then
  echo "等待服务启动：http://127.0.0.1:5188"
  ready=0
  for _ in $(seq 1 30); do
    if curl -sS -o /dev/null "http://127.0.0.1:5188" 2>/dev/null; then ready=1; break; fi
    sleep 2
  done
  if [ "$ready" = "1" ]; then
    echo "服务已就绪"
  else
    echo "警告：60 秒内未探测到 http://127.0.0.1:5188，请手动打开确认或查看日志"
    exit 1
  fi
else
  echo "未检测到 curl，跳过启动探测；请手动访问 http://127.0.0.1:5188 确认"
fi
echo "部署完成：打开 http://127.0.0.1:5188，先定每日计划，再按 FSRS 安排复习"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/designfuchen/word-atlas/blob/main/docs/deployment.md"
