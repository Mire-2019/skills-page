# office-hours 适配改造单

> 本文件是一份**真实审查记录**（非示例模板）。
> 原稿里的本机绝对路径已脱敏为占位符，其余内容未改。

- **本地名**：office-hours
- **源**：`crealwork/yc-office-hours`
- **源说明**：YC 合伙人 office hours 的 skill 复刻版。8 步评审会话 + 3 模式（IDEA / GROWTH / CAMPAIGN）+ 4 个资源文件。MIT。
- **发现日期**：2026-08-20
- **改造类型**：② 改造（拿外部 SKILL.md 改写为本地版，保留 question-bank / evaluation-rubric / partner-voice 三个原版资源）
- **改造日期**：2026-08-20

## 改动清单（对比 `<staging_dir>\crealwork__yc-office-hours\` 原版 4 文件）

**SKILL.md**：

- frontmatter 换本地名 `office-hours`，description 改为中英双语触发描述（保留英文触发词以兼容）
- 加 `source:` + `adaptVersion: 1.1.0`（本地改造版起步版本）
- 正文中文化；加铁律 5 条：一次一题、每轮收口、结论先行 + 证据分层、本地工具范式（落工作盘）、永远给裁决
- 保留 8 步流程全部原意，体制与出处写明
- 新增「与本地评审类 skill 的关系」：破坏面定位（office-hours 只做创业评审，实现方案回到另一个 skill）
- 文末加「关于本文件」指向 skill-adapt 台账

**question-bank.md / evaluation-rubric.md / partner-voice.md**：原样保留（英文，术语与问题库属工具性内容，改造不动核）

**新增**：无新脚本（纯文档型 skill，无 scripts）

## 改造后三重验证

- ① 目录结构：SKILL.md + 3 个资源文件齐全 ✓
- ② frontmatter 契约：`name / description / source / adaptVersion` 齐全 ✓
- ③ 关键命令 dry-run：无 shell 命令（本 skill 运行时只读文档，无 Bash 依赖）✓

## 当前状态

- [ ] 待用户拍板
- [ ] 拍板后建立链接：`mklink /J "%USERPROFILE%\.claude\skills\office-hours" "<install_dir>\office-hours"`
- [ ] 确认出现在 `npx skills list -g` 里 → 装后更新台账与本地记忆

---

**这份报告说明了什么**：一个纯文档型外部 skill 的完整改造单 —— 改造类型、逐条改动清单、三重验证结果、
待拍板状态。注意最后一步是**等用户拍板**，不是自动装。这就是「工具是原料，不是成品」的具体形状。
