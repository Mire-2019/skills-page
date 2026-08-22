# 来源路由（source-routing）

把用户给的「新 skill 来源」解析成候选 skill 名单。输入类型 → 处理方式 → 输出。

## 输入类型映射

| 输入 | 处理方式 | 输出 |
|---|---|---|
| **B站视频链接**（b23.tv / BV 号） | 复用已有的 **bili-video-digest** skill 拆出视频要点 → 从中提取提到的 skill 名/仓库 | skill 名单 + 关联上下文 |
| **公众号/新闻/普通网页链接** | WebFetch 抓正文 → 提取 skill 名/仓库 | skill 名单 |
| **GitHub 仓库链接** | `curl` 拉 README（raw.githubusercontent.com）→ 找 SKILL.md / 目录结构 → 识别 skill 系列 | 该仓库的 skill 名清单 |
| **一行指令/纯文字**（「帮我装 xxx skill」「我刷到 xxx 技能」） | 直接当关键词：`npx skills find <kw>`（**必须 PowerShell**，否则空输出）+ WebSearch 补齐 | skill 候选清单 |

## 解析产物统一格式

每次触发产出一份 `download-info.json` 放暂存区：

```json
{
  "source": "bilibili|web|github|text",
  "source_url": "https://...",
  "skill_names": ["xxx", "yyy"],
  "keywords": ["..."],
  "parsed_at": "2026-08-20"
}
```

## 规则

- **B站场景**：优先复用 bili-video-digest，不重复造「视频拆解」轮子；它返回的要点里若直接提到 skill 仓库，直接收录。
- **GitHub 场景**：仓库可能是「单个 skill」也可能是一整包（多 SKILL.md 子目录）。用 `--full-depth` 思路识别**每个** SKILL.md，都是一份候选。
- **关键词场景**：`npx skills find` 必须在 PowerShell 下跑；搜不到再用 WebSearch 兜底。
- 拿到的候选名一律进第 1 步「下载不安装」的 clone 流程，不直接装。