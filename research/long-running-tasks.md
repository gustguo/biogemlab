# 长期任务 — 网站内容更新

_这些任务没有明确的 Deadline，需要持续执行。新创建的 HTML 页面或 Blog 文章必须遵循以下规则。_

---

## 🔄 任务 A：Blog 文章持续更新

**目标：** 保持 Blog 栏目活跃，定期发布与 memorial diamond 相关的 SEO 内容。

**更新频率：** 每 1–2 周至少一篇新文章。

**选题方向：**
- HPHT/CVD 技术科普
- 碳源纯度与钻石质量关系
- 纪念钻石生产周期详解
- 合作商/经销商指南
- 行业对比（我方 vs 竞品）
- 客户案例（Moutai、Silmaril 等）

---

## ⚠️ 页面规范 — 必须遵守

### 规则 1：所有 HTML 页面必须包含 Canonical 标签

**要求：** 每个 `.html` 文件的 `<head>` 区域必须包含：

```html
<link rel="canonical" href="https://www.biogemlab.com/当前页面路径">
```

**示例：**
- 根页面：`href="https://www.biogemlab.com/"`
- 主页面：`href="https://www.biogemlab.com/technology.html"`
- Blog 首页：`href="https://www.biogemlab.com/blog/"`
- Blog 子页面：`href="https://www.biogemlab.com/blog/article-slug.html"`

**为什么：** 防止 Google 将 `www` / 裸域 / HTTP / HTTPS 的多个版本视为重复内容，导致索引分散或"Page with redirect"错误。

**检查命令：**
```bash
grep -n 'rel="canonical"' filename.html
```

---

### 规则 2：导航栏中的 Blog 链接必须使用 Trailing Slash

**要求：** 根目录页面导航栏中的 Resources/Blog 链接必须使用：

```html
href="blog/"
```

**禁止：**
```html
href="blog/index.html"   ❌ 会产生多余的文件扩展名暴露
href="blog"             ❌ 会触发 301 重定向到 blog/
```

**Blog 子页面内部的导航保留现有格式：**
- Blog 首页链接：`href="index.html"`（在 blog/ 目录内，相对路径正确）
- 返回首页：`href="../index.html"`（相对路径正确）

**为什么：** GitHub Pages 对目录的默认行为是将 `blog` 301 重定向到 `blog/`。如果页面内链写 `blog/index.html`，Google 会记录一个不必要的中间跳转；如果写 `blog`，用户先 301 到 `blog/` 再 200，浪费爬取配额。

---

### 规则 3：OG URL 和 Twitter URL 必须与 Canonical 一致

**要求：** Open Graph `og:url` 和 Twitter Card 的 URL 必须与 canonical 标签指向同一个规范 URL。

**示例：**
```html
<meta property="og:url" content="https://www.biogemlab.com/partnership.html">
<link rel="canonical" href="https://www.biogemlab.com/partnership.html">
```

**禁止：** OG URL 写 `http://` 或裸域，而 canonical 写 `https://www`。

---

### 规则 4：新页面创建后同步到 biogemlab 目录并 Push

**要求：** 所有修改先在 `biogemlab-website/` 目录完成，然后复制到 `biogemlab/` 目录，最后 `git add + commit + push`。

**为什么：** `biogemlab-website/` 是工作副本，`biogemlab/` 是 Git 仓库。只有 push 到 GitHub 后 GitHub Pages 才会更新。

---

## 🔍 验证清单（每次更新后执行）

1. **检查 canonical：** `grep 'rel="canonical"' 新文件.html`
2. **检查 blog 链接：** `grep 'href="blog' *.html`（确保没有 `blog/index.html` 或 `blog"`）
3. **检查 OG URL：** `grep 'og:url' 新文件.html`
4. **检查是否有 HTTP 裸链接：** `grep 'http://biogemlab.com' 新文件.html`（应为 `https://www.biogemlab.com`）
5. **Git push 后验证：** `curl -sL https://www.biogemlab.com/新页面 | grep 'rel="canonical"'`

---

*Created: 2026-05-13*
*Last updated: 2026-05-13*
