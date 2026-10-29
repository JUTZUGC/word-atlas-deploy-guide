# Word Atlas 一键部署指南

> 第三方部署指南 · 非 Word Atlas 官方仓库。官方项目：[designfuchen/word-atlas](https://github.com/designfuchen/word-atlas)
> 内容来自官方文档（2026-10-29）。项目迭代快，请以[官方文档](https://github.com/designfuchen/word-atlas/blob/main/docs/deployment.md)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 把 7298 个雅思词做成能看、能听、能复习的图鉴，本地跑起来就能学。

⚠️ 需要 Node.js 20+ 与 npm。仓库自带 7298 幅插画和 22905 段录音，完整克隆体积较大，建议用 --depth 1。学习进度存在浏览器本地，换设备前先导出备份。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/word-atlas-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会浅克隆仓库、npm ci 安装依赖，再启动 Vite 开发服务器，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）

4. **打开管理面板**
   浏览器访问 [http://127.0.0.1:5188](http://127.0.0.1:5188)，按官方引导完成初始化配置。

## Word Atlas 是什么？

Word Atlas 是开源的插画式雅思背单词应用，7298 个词条配原创插画、英美发音与 FSRS 间隔复习（协议：MIT（代码）+ CC BY 4.0（词库），<img src="https://img.shields.io/github/stars/designfuchen/word-atlas?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

以插画和语境为核心的雅思背词应用：每个词条有插画、中英释义、两条例句、英美发音，配合主动回忆与 FSRS 间隔复习；词库同时以 JSON / CSV 开放。

- 7298 个词条：CEFR A1–C2，19 个话题
- 7298 幅插画：每个词一张原创图，512px WebP
- 22905 段录音：英音、美音与例句朗读
- FSRS 复习：按学习记录安排，目标记忆率可调
- 词汇星图：WebGL2 渲染，按话题看进度
- 本地优先：无需账号，进度存在设备上
- 词库开放：JSON / CSV 可直接做 Anki 牌组或研究

（来源：[官方仓库](https://github.com/designfuchen/word-atlas)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 3 | . |
| 素 | 材 |
| 学 | 习 |
| 词 | 库 |
| 本 | 地 |
| M | I |

| 需要注意 | 说明 |
|---|---|
| 仓 | 库 |
| 只 | 覆 |
| 没 | 有 |
| 星 | 图 |
| 开 | 源 |

> 以上基于官方文档与社区反馈整理（2026-10-29），以官方最新文档为准。

## 快速部署（官方方式）

```bash
node -e "const a=+process.versions.node.split('.')[0]; if(a<20){console.error('需要 Node.js 20+，当前 '+process.versions.node);process.exit(1)}"
git clone --depth 1 https://github.com/designfuchen/word-atlas.git
cd word-atlas
npm ci
nohup npm run dev > word-atlas.log 2>&1 &
echo "已启动：http://127.0.0.1:5188"
```

启动后浏览器访问 [http://127.0.0.1:5188](http://127.0.0.1:5188)（管理面板）。（来源：[https://github.com/designfuchen/word-atlas/blob/main/docs/deployment.md](https://github.com/designfuchen/word-atlas/blob/main/docs/deployment.md)）

## 验证状态

| 场景 | 状态 |
|---|---|
| README 本地运行章节确认 Node 20+、npm ci、端口 5188 | 已核对 2026-10-29 |
| README 确认词条 7298、例句 14596、插画 7298、录音 22905 | 已核对 2026-10-29 |
| License 徽章确认代码 MIT、词库 CC BY 4.0 | 已核对 2026-10-29 |
| 未实测克隆与 npm ci（仓库体积较大） | 说明 2026-10-29 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-29 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-29 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供部署步骤、词库字段与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-29）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\word-atlas-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 词库怎么用

仓库同时开放了词库，JSON 与 CSV 都在 `data/`：

```python
import json
from pathlib import Path

words = json.loads(Path("data/word-atlas.json").read_text(encoding="utf-8"))
b2 = [w for w in words if w["cefr"] == "B2" and w["topic"] == "environment"]
```

| 资源 | 数量 | 位置 |
|---|---|---|
| 词条 | 7298 条 | data/word-atlas.json / .csv |
| 例句 | 14596 条 | 词条内 |
| 插画 | 7298 幅 | public/atlas/img/ |
| 录音 | 22905 段 | public/atlas/audio/ |

## 部署到子路径

```bash
ATLAS_BASE=/words/ npm run build
```

构建产物在 `dist/`，交给任意静态服务器即可。完整说明见官方 docs/deployment.md。

## 注意

- 完整仓库含大量图片与音频，克隆慢是正常的
- 进度在浏览器本地，换设备前先导出
- 星图依赖 WebGL2，老设备会走降级显示
- 代码 MIT，词库与插画为 CC BY 4.0，二次分发要保留署名

## 常见坑

- Node 版本不够：升级到 20+ 再 npm ci
- npm ci 失败：确认在仓库根目录，且 package-lock.json 存在
- 端口 5188 被占用：改 vite 配置或先停占用进程
- 克隆太慢：用 git clone --depth 1，或只下 data/ 与 public/
- 页面没有声音：浏览器自动播放限制，先点一下页面再播放
- 换设备进度没了：之前要在设置里导出备份

## 免责声明

本仓库为第三方指南，与 Word Atlas 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-29），项目迭代快，请以[官方文档](https://github.com/designfuchen/word-atlas/blob/main/docs/deployment.md)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
