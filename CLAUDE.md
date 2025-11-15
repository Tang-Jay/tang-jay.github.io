# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal website/blog built with Hugo static site generator. The site is bilingual (Chinese/English) and uses the hugo-ivy theme (forked from Yihui Xie's repository). The site is deployed to GitHub Pages and can also be deployed to Netlify or Vercel.

**Key characteristics:**
- Static site generator: Hugo v0.25.1 (configured for deployment platforms)
- Theme: hugo-ivy (located in `themes/hugo-ivy/`)
- Output directory: `docs/` (for GitHub Pages compatibility)
- Base URL: https://tang-jay.github.io/
- Content languages: Chinese (primary in `content/cn/`) and English
- Disqus comments enabled with shortname "tanjay"

## Development Commands

### Local Development

```bash
# Start Hugo development server (includes drafts)
hugo server -D

# Start Hugo development server with future posts
hugo server -D -F

# Build site for production (output to docs/)
hugo

# Build site including drafts (for preview)
hugo -D
```

### Build and Deployment

```bash
# Build for production (used by Netlify/Vercel)
./build.sh

# Build and deploy to GitHub (automated script)
./deploy.sh
```

**Build script behavior (`build.sh`):**
- On Netlify: Creates robots.txt to disallow all crawlers (only Vercel version is indexed)
- Production builds: `hugo -F` (includes future-dated posts)
- Non-production builds: `hugo -F -D -b <deploy-url>` (includes drafts and uses deploy URL)

**Deploy script behavior (`deploy.sh`):**
- Builds site with drafts: `hugo -D`
- Stages all changes: `git add .`
- Creates commit with timestamp: "自动部署: YYYY-MM-DD HH:MM"
- Pushes to `main` branch

### Testing

This project does not have automated tests. Manual testing involves:
1. Running `hugo server -D` to preview locally
2. Checking content rendering in browser
3. Verifying links and images work correctly

## Architecture and Structure

### Directory Structure

```
.
├── config.yaml           # Hugo configuration (site settings, menus, params)
├── content/              # Markdown content files
│   ├── _index.md        # Homepage content
│   ├── resume.md        # Resume/CV page
│   ├── cn/              # Chinese blog posts (143 posts)
│   └── *.md             # Other standalone pages
├── layouts/              # Custom layout overrides
│   ├── _default/        # Default templates
│   └── partials/        # Partial templates (11 files)
├── static/               # Static assets (images, CSS, JS, PDFs)
│   ├── css/             # Custom stylesheets
│   ├── images/          # Site images and logos
│   ├── cajs/            # Custom JavaScript files
│   ├── papers/          # Academic papers
│   ├── certificate/     # Certificates
│   └── *.jpg, *.jpeg    # Various image assets
├── themes/hugo-ivy/      # Hugo theme (git submodule or copy)
├── docs/                 # Generated site (published to GitHub Pages)
├── build.sh             # Build script for Netlify/Vercel
└── deploy.sh            # Automated deployment script
```

### Content Organization

**Content structure:**
- Homepage: `content/_index.md` - Main landing page
- Resume: `content/resume.md` - CV/resume page
- Chinese blog: `content/cn/` - Contains 143+ blog posts organized by date
- Standalone pages: Various `.md` files in `content/` root

**URL structure (from config.yaml):**
- Chinese posts: `/:sections/:year/:month/:day/:slug/`
- Other content: Default Hugo permalinks

### Theme Customization

The site uses the hugo-ivy theme with customizations:

**Custom JavaScript (loaded via config.yaml):**
- `fix-toc.js` - Table of contents fixes
- `center-img.js` - Center images
- `right-quote.js` - Quote formatting
- `no-highlight.js` - Syntax highlighting control
- `fix-footnote.js` - Footnote formatting
- `math-code.js` - Math rendering support
- `hash-notes.js` - Hash-based notes
- `external-link.js` - External link handling
- `alt-title.js` - Alternative titles
- `header-link.js` - Header link generation

**Syntax highlighting:**
- Version: highlight.js 9.12.0
- Languages: R, YAML, TeX
- Theme: GitHub style

**Layout overrides:**
- Custom 404 page: `layouts/404.html`
- Partial templates in `layouts/partials/` override theme defaults

### Deployment Architecture

**Multi-platform deployment:**

1. **GitHub Pages** (primary):
   - Publishes from `docs/` directory
   - Branch: `main`
   - URL: https://tang-jay.github.io/

2. **Vercel** (production):
   - Uses `vercel.json` configuration
   - Hugo version: 0.25.1
   - Includes extensive redirect rules (127 redirects)
   - Trailing slash enabled
   - CORS headers configured for `/disqus/` API proxy

3. **Netlify** (alternative):
   - Uses `netlify.toml` configuration
   - Hugo version: 0.25.1
   - Robots.txt blocks all crawlers (Vercel is preferred for indexing)
   - Build command: `./build.sh`
   - Publish directory: `docs`

**Important deployment notes:**
- The site is configured to prevent duplicate indexing by search engines
- Netlify builds are blocked from crawlers via robots.txt
- Only the Vercel deployment should be indexed
- Build scripts detect environment variables (`NETLIFY`, `VERCEL_ENV`, `CONTEXT`) to adjust behavior

### Configuration Details

**Key config.yaml settings:**
- `publishDir: "docs"` - Output directory for GitHub Pages
- `hasCJKLanguage: true` - Enables CJK (Chinese/Japanese/Korean) language support
- `enableEmoji: true` - Emoji support in content
- `disqusShortname: "tanjay"` - Comments integration
- `ignoreFiles: ["\\.Rmd$", "\\.Rmarkdown$", "_cache$"]` - Ignores R Markdown files
- `rssLimit: 10` - Limits RSS feed to 10 items

**Menu structure (Chinese):**
1. 主页 (Home) - `/`
2. 简历 (Resume) - `/resume/`
3. 日志 (Blog) - `/cn/`
4. 目录 (Categories) - `/categories/`
5. 标签 (Tags) - `/tags/`

## Working with Content

### Creating New Posts

Chinese blog posts should be created in `content/cn/` with the naming pattern:
```
YYYY-MM-DD-slug.md
```

Front matter should include:
```yaml
---
title: "Post Title"
date: YYYY-MM-DD
slug: "post-slug"
categories: ["Category"]
tags: ["tag1", "tag2"]
---
```

### Adding Static Assets

- Images: Place in `static/images/`
- PDFs/Papers: Place in `static/papers/`
- Custom CSS: Place in `static/css/`
- Custom JS: Place in `static/cajs/` and reference in `config.yaml`

### Modifying Layouts

To override theme templates:
1. Copy template from `themes/hugo-ivy/layouts/` to `layouts/`
2. Modify the copied file
3. Hugo will use your override instead of the theme default

## Important Notes

- **Hugo version mismatch**: Config files specify Hugo 0.25.1, but local installation is v0.131.0. This may cause rendering differences between local and deployed versions.
- **Theme source**: The hugo-ivy theme is based on Yihui Xie's repository. See README.md for original source.
- **Git workflow**: The `deploy.sh` script automatically commits and pushes changes. Review changes before running.
- **Disqus integration**: Comments are enabled site-wide with shortname "tanjay" and custom URL configuration.
- **Vercel redirects**: The `vercel.json` file contains 127 redirect rules, many pointing to external domains (yihui.org, GitHub, etc.). Be careful when modifying.
