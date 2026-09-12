# Agent-Reach 本地适配台账

> 本文件是一份**真实审查记录**（非示例模板）。
> 原稿里的本机绝对路径已脱敏为占位符，其余内容未改。

- **源**：`Panniantong/Agent-Reach`（https://github.com/Panniantong/Agent-Reach）
- **适配类型**：② 改造（精简本地版）
- **适配日期**：2026-09-01
- **本地名**：agent-reach

## 改动清单（相对原版）

1. **聚焦核心信息来源**：小红书 / B站 / GitHub / 网页·搜索；其余社交登录态平台（推特 / Reddit / FB / IG）暂不进。
2. **触发词保持全宽不收窄**（小红书 / 平台名 / URL / 搜索 / 调研 / 查 / 找）。
3. **去除原版「替用户盯版本 + 自动附更新话术 + 每日监控 cron」的回流设计** —— 这部分对本地是负担。
4. **路径与命令本地化**：`/tmp/` → `$env:TEMP`，命令面向 Windows + PowerShell。
5. **小红书登录态明确**：不自动登录、不读浏览器 Cookie，复用用户已有的 Chrome 会话，建议用专用小号。

## 装机进度（2026-09-01）

- agent-reach CLI v1.5.0：已装（隔离 venv `<工作盘>\.agent-reach-venv`，本地源码构建 + 镜像源依赖）。
- B站（bili-cli 0.6.2）、YouTube（yt-dlp + 已配 `--js-runtimes node`）、网页（Jina）、RSS、全网搜索（mcporter + Exa MCP）→ `doctor` 全部 **ok**。
- opencli 1.8.7：npm 已装；医生检出 Chrome 里已有扩展文件，但**扩展未连接**（待用户启用 + Chrome 登录小红书后 `opencli doctor` 验证）。
- GitHub（gh CLI）：**未装**。本机到 github.com / ghproxy 等站点连接超时（无代理），包管理器下载失败 —— 需用户提供网络后才能装。

## 未完成项（需用户参与）

- 小红书登录态：用户启用浏览器扩展 + 登录小红书 → `opencli doctor` 确认连接。
- GitHub：等网络可用后装 gh CLI。
- 装好后跑 `agent-reach doctor --json` 做真实验证。

---

**这份报告说明了什么**：一个「看起来很香」的抓取 skill，原版带了 15 个平台 + 一套盯版本 / 自动发更新话术 / 每日定时任务的回流设计。四段式分析判它有价值，整合分析判它**带了一堆不需要的**，改造时砍掉，安全上也改了一处（登录态的处理方式）。这就是三道工序的产出。
