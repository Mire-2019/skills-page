# local-adapt：外部 skill 的本地落地规程

> 本页是 skill-adapt 铁律 7 的**执行细则**：所有外部 skill 一律改造后装，绝无「直接原样装进来」路径。例外仅两档（重复/无价值/安全否决 → ④借鉴笔记）。

## 入口判断

收到任何外部 skill（B站/公众号/GitHub/一句话指令）→ 先走 [source-routing](source-routing.md) → **download 不装** → 三道工序 → 本页第 1 步。

## 六步落零锁（每步产出物）

| 步 | 动作 | 产出 |
|---|---|---|
| 1 | **领名 + 建档** | 本地改造版新 skill 名 + `skill-reports/` 一单存根（source/日期/类型/改动清单） |
| 2 | **重写/融合 SKILL.md** | 全中文正文 + 本地约束（工作盘/字段 ID/口径/file:// 交付/证据分层）+ `source:` + `version: 1.1.0` + 「关于本文件」 |
| 3 | **脚本合规化** | scripts 无 C 盘/无凭据外传/路径 D 盘/不装额外依赖 |
| 4 | **三重验证** | `scripts/verify-adaptation.sh` ①目录 ②frontmatter ③关键命令 dry-run |
| 5 | **报告 + 拍板** | 本地改造版 vs 原版 diff 摘要 → 等你拍板 |
| 6 | **装后更新** | `npx skills list` 确认 → 更新台账 + 记忆 reference_claude-skills.md |

## 本地化改造时的「默认贴合」项（读 profile-reading.md 后按需自动套）

- **全中文**：正文/注释中文，术语（字段 ID/口径/API/CDP/cube/measure）除外。
- **落盘 D 盘**：一切产物 D 盘；脚本禁 C 盘路径。
- **交付 file://**：HTML 交付一律本地绝对路径开；上传妙搭/外发先审批。
- **证据分层**：事实 / 推断 / 待确认，不空口断言；数字带口径引用。
- **工具范式**：项目自有工具优先（如 BI 走数据连接复用登录、协同办公走办公套件 API 身份分清楚、报告走正规工作流），通用工具范式可提。
- **安全**：脚本不 curl 外传数据、不碰敏感凭据、不写 C 盘；发现可疑 → 安全栏一票否决。

## 例外（④只借鉴不装）

判「重复 / 无价值 / 安全否决」→ 存一行借鉴笔记进 `skill-reports/`（要点 + 来源链接），**不搬正文本体**。

## 与 creator 的关系

- **自建 skill** → skill-creator（grill 磨需求 → creator 打磨评测）。
- **外部 skill** → 本规程强制改造后装。
- 两者不冲突：外部 skill 改造时可参考 creator 的评测手法做回归冒烟，但**入口/决策都归 adapt**。