# skill-adapt

**装 skill 之前，先过三道工序。**

把外部 skill 当**原料**而不是成品：先审、再比、后改，产出「适配到你本地、可拍板可装」的版本，最后由你决定装不装。

> 如果你是从 B 站视频过来的：视频里讲的「三道工序」就是这套东西，下面是完整的安装和使用说明。

---

## 它解决什么问题

看到别人推荐一个 skill，你装上了。用两天，发现不好用。更尴尬的是 —— 你电脑里本来就有三个干同样事的。

外部 skill 有三个坑：

| | 坑 | 长什么样 |
|---|---|---|
| **01** | **重复** | 本地早就有了，你不知道 |
| **02** | **白装** | 用两天，用不上 |
| **03** | **安全** | 脚本里写着 `curl`，把你的数据往不知道哪儿的域名发 |

`skill-adapt` 是装前审查：**这三件事在装之前就查清楚**，而不是装完再后悔。

---

## 三道工序

```
拿到一个新 skill 来源（B站 / 公众号 / GitHub / 一句话）
        │
        ▼
① 价值分析 ── 下载不安装 → 扫三层基线 → 全网检索 → 安全栏 + 价值观栏
        │       产出：四段式分析（工作原理 / 设计意图 / 适用边界 / 隐含假设）
        │
        ▼  ⏸ 决策门：等你拍板
② 整合分析 ── 跟本地近亲逐个对话（互补？重复？有张力？）
        │       产出：整合方案（留哪个、并哪个、怎么分工）
        │
        ▼  ⏸ 决策门：等你拍板
③ 适配改造 ── 先出决策点清单 → 你逐项拍板 → 才动笔
        │       产出：本地改造版 + 改动理由 + 恢复原版的代价
        │
        ▼  ⏸ 决策门：等你拍板
     安装（或：只借鉴不装）
```

**两个决策门是这套方法的关键。** 工具是原料，不是成品 —— 改什么、砍什么、装不装，都由你拍板。

---

## 安装

前置：一个能读 `SKILL.md` 的 agent（Claude Code 等），已装 `git`。

### 方式一：手动（通用）

**macOS / Linux**

```bash
git clone --depth 1 https://github.com/Mire-2019/skills-page.git /tmp/skill-adapt
mkdir -p ~/.claude/skills
cp -r /tmp/skill-adapt ~/.claude/skills/skill-adapt
ls ~/.claude/skills/skill-adapt/SKILL.md   # 确认装上了
```

**Windows PowerShell**

```powershell
git clone --depth 1 https://github.com/Mire-2019/skills-page.git "$env:TEMP\skill-adapt"
New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude\skills" | Out-Null
Copy-Item "$env:TEMP\skill-adapt" "$env:USERPROFILE\.claude\skills\skill-adapt" -Recurse
Test-Path "$env:USERPROFILE\.claude\skills\skill-adapt\SKILL.md"   # 应为 True
```

### 方式二：直接放进你的 skills 目录

把本仓库整个目录拷进你的 skills 目录，改名为 `skill-adapt` 即可。**没有构建步骤，没有依赖**，`scripts/` 是三个 shell 脚本。

> **装完必须做一件事** —— 见下一节。

---

## ⚙️ 装完先改这 8 行

`SKILL.md` 开头有一个配置块，**默认值是作者一台 Windows 工作机的配置**。
不改它，这个 skill 会往作者的目录里写东西 —— **换成你自己的路径再用**。

```yaml
staging_dir:   D:\ClaudeCode\skills-staging      # 暂存区：下载不安装，只读
install_dir:   D:\ClaudeCode\skills              # 改造版最终落到哪
agent_dir:     ~\.claude\skills                  # agent 读取 skill 的目录
report_dir:    ./skill-reports                   # 审查报告 / 借鉴笔记
verify_cmd:    npx skills list                   # 装完拿什么确认
memory_index:  MEMORY.md                         # 你的项目约定 / 记忆索引（没有就留空）
office_suite:  lark-cli                          # 你用的办公套件内置能力（没有就留空）
kin_skills:    grilling, creator, office-hours   # 你本地已有的同类 skill（没有就留空）
```

**这是全篇唯一需要改的地方。** 方法部分与机器无关，可以照搬。

---

## 它会产出什么

`skill-reports/` 里有两份**真实报告**（不是示例模板，是实际跑出来的）：

- [`skill-reports/agent-reach.md`](skill-reports/agent-reach.md) —— 一个开源抓取 skill 的完整审查：四段式分析、砍掉哪些能力、安全上改了哪一处
- [`skill-reports/office-hours.md`](skill-reports/office-hours.md)

想知道「用它审一个 skill 长什么样」，直接看这两份。

---

## 不适用场景

| 你的情况 | 该用 |
|---|---|
| 从 0 写一个全新 skill | 创作类 skill，不是这个 |
| 只想搜一下有没有某个 skill | 检索类 skill，别套三道工序 |
| 改本地已有的 skill | 那是迭代，不是适配 |
| 定期体检整个技能库 | 这是另一件事 —— **本 skill 明确不做**订阅 / 定期扫描 |
| 已经确定要装、只问怎么装 | 直接装 |

**本 skill 是纯被动的**：你给它一个新 skill 来源，它才开工；装完确认即止。

---

## 目录结构

```
SKILL.md                     配置块 + 铁律 + 三道工序（主文件）
README.md                    本文件
LICENSE                      MIT
CHANGELOG.md                 版本记录
references/
  source-routing.md          各类来源 → 对应解析器映射
  baseline-scan.md           三层基线扫描规则
  profile-reading.md         读本地约定指引
  decision-points.md         改造决策点清单模板
scripts/
  gitclone.sh                暂存区 clone（下载不安装）
  make-adaptation.sh         按类型改写 SKILL.md（组装 / 改造 / 定制）
  verify-adaptation.sh       三重验证
skill-reports/               真实审查报告
```

---

## 出处与许可

- 思路与流程受 [`anthropics/skills`](https://github.com/anthropics/skills) 生态启发，独立适配改造完成。
- 非 Anthropic 官方产物。
- MIT，详见 [LICENSE](LICENSE)。

---

## 一句话

**工具是原料，不是成品。**
