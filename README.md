# BioGem Lab — B2B Memorial Diamond Manufacturing Website

> White-label HPHT diamond synthesis laboratory serving pet aftercare providers worldwide.
> Live at: **https://www.biogemlab.com**

---

## What This Is

This repository hosts the static website for **BioGem Lab**, a B2B OEM/white-label memorial diamond production facility based in Luoyang, China. The site is designed for **pet cremation services, veterinary clinics, pet groomers, and memorial product distributors** who want to add legacy diamond services to their offerings.

**Positioning**: We do NOT sell directly to consumers. All partnerships are B2B white-label/OEM.

---

## Tech Stack

| Layer | Choice |
|-------|--------|
| Framework | Pure static HTML (no React/Next.js) |
| Styling | Tailwind CSS CDN |
| Fonts | Inter + Crimson Pro (Google Fonts) |
| Hosting | GitHub Pages |
| Domain | `www.biogemlab.com` (CNAME) |
| Analytics | Google Analytics 4 — `G-W4JJ8RGFWC` |

---

## Site Structure

```
biogemlab/
├── index.html              # Homepage
├── technology.html         # HPHT process & patent
├── manufacturing.html      # Production infrastructure
├── laboratory.html         # Lab capabilities
├── partnership.html        # White-label program
├── applications.html       # Use cases & partner stories
├── contact.html            # Contact & trust cards
├── faq.html                # FAQ
├── blog/
│   ├── index.html          # Blog landing (9 articles)
│   ├── hpht-vs-cvd-...
│   ├── carbon-source-...
│   ├── memorial-diamond-production-cycle.html
│   ├── white-label-...
│   ├── hair-to-diamond-...
│   ├── oem-memorial-...
│   ├── choosing-memorial-diamond-supplier.html
│   └── graphitization-...
├── assets/
│   └── images/             # 78 lab photos in categorized dirs
├── robots.txt
├── sitemap.xml
└── CNAME                   # www.biogemlab.com
```

---

## Maintenance Log

| Date | Commit | Change |
|------|--------|--------|
| 2026-05-07 | `d757bdd` | Schema.org structured data (Organization + WebSite + WebPage) |
| 2026-05-07 | `ac4ab1b` | Fix Schema — `alternateName` → 生命宝石实验室, remove phone |
| 2026-05-07 | `c212db2` | Contact page — schedule call, business hours, full address |
| 2026-05-08 | `431ebbe` | Applications page — partner case studies (Silmaril / Peony / Heritage) |
| 2026-05-08 | `fa776ca` | Replace Silmaril photo with illustration (portrait-rights fix) |
| 2026-05-12 | `e55f488` | Deploy 78 real lab photos replacing all Unsplash placeholders |
| 2026-05-12 | `644` | Image deduplication — 33 unique images, zero cross-page duplicates |
| 2026-05-12 | `e849ed1` | 4 new SEO blog articles + blog index update |
| 2026-05-12 | `06f5d15` | GA4 + B2B conversion tracking (`email_click`, `whatsapp_click`) |
| 2026-05-12 | `a5f0d34` | `robots.txt` + `sitemap.xml` deployed |

---

## Design System

| Token | Value |
|-------|-------|
| Brand Gold | `#C5A059` |
| Dark Background | `#0B0F17` |
| Light Surface | `#F7F8FA` |
| Body Font | Inter |
| Heading Font | Crimson Pro |

---

## Image Policy

- **All images must be unique** — no cross-page repeats, no within-page repeats
- **No identifiable human faces** — avoids portrait-rights risk
- **Chinese elements allowed** — lab location (Luoyang), CCIC certificates, patent references permitted since 2026-05-12
- **78 photos delivered** by photographer; 33 used across site; ~22 remaining for future blog articles
- **Exhaustion protocol**: Alert when remaining drops below 3

---

## SEO/GEO Configuration

- **Schema.org**: Organization + WebSite + WebPage (homepage) + Article (blog)
- **Sitemap**: 18 URLs with priority/changefreq/lastmod
- **Search Console**: Sitemap submitted, indexing in progress
- **Blog cadence**: 2 articles/week (industrial SEO authority building)
- **Tone**: Industrial whitepaper — synthesis, purification, process validation, carbon engineering

---

## Key Identifiers

| Item | Value |
|------|-------|
| Patent | `ZL 2010 1 0565778.9` (CNIPA) |
| Certificate | `1058820` |
| Contact Email | `partners@biogemlab.com` |
| WhatsApp | `+1 (310) 437-3166` |
| Business Hours | Mon–Fri 9:00–18:00 CST (GMT+8) |
| Address | Luoyang Institute of Technology / National University Science Park / Luoyang, Henan, China |

---

## Deployment

```bash
# Working copy → deploy
rsync -av --delete biogemlab-website/ biogemlab/
cd biogemlab
git add .
git commit -m "..."
git push origin main
```

---

*Last updated: 2026-05-12*
