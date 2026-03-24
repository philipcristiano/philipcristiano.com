# philipcristiano.com

Personal site built with [Zola](https://www.getzola.org/) and deployed to Netlify.

## Local development

With Nix:
```sh
nix develop
zola serve
```

Without Nix (requires `zola` in PATH):
```sh
zola serve
```

The site is available at `http://127.0.0.1:1111`. Changes to templates and content hot-reload automatically.

## Build

```sh
make build          # production build → public/
make build_preview  # preview build with base_url "/"
```

Zola version pinned in `netlify.toml` (`ZOLA_VERSION`).

## Deployment

Pushing to `main` triggers a GitHub Actions workflow that:
1. Builds via Nix + `make build`
2. Deploys to GitHub Pages (production)
3. Sends webmentions for any updated pages

Pull requests run `make build_preview` to verify the build but do not deploy a preview.

## Content types

All content lives under `content/`. Each type has its own section with a corresponding page template.

| Type | Path | Template | Notes |
|------|------|----------|-------|
| Posts | `content/posts/YEAR/SLUG/index.md` | `post.html` | Long-form; supports ToC, math, code highlight |
| Notes | `content/notes/YEAR/YYYYMMDDHHMMSS/index.md` | `note.html` | Short-form, no title |
| Likes | `content/likes/YEAR/YYYYMMDDHHMMSS/index.md` | `like.html` | Requires `extra.in_like_of` URL |
| Replies | `content/replies/YEAR/YYYYMMDDHHMMSS/index.md` | `reply.html` | Requires `extra.in_reply_to` URL |
| Photos | `content/photos/YEAR/SLUG/index.md` | `photo_gallery.html` | Images as page assets |
| Recommendations | `content/recommendations/SLUG.md` | `recommendation.html` | Requires `extra.url`; optional `extra.feed` |

### Post front matter

```toml
+++
title = "Post title"
date = "2026-01-01"
[taxonomies]
tags = ["tag1", "tag2"]
[extra]
toc = true          # show table of contents (optional)
+++
```

Add `<!-- more -->` in the body to set an explicit feed excerpt. Without it, the feed shows the first 200 characters.

### Note / like / reply front matter

```toml
+++
date = "2026-01-01T12:00:00Z"
[taxonomies]
tags = ["tag"]
[extra]
in_like_of = "https://example.com/post"   # likes only
in_reply_to = "https://example.com/post"  # replies only
+++
```

### Recommendation front matter

```toml
+++
title = "Site Name"
date = "2026-01-01"
[extra]
url = "https://example.com"
feed = "https://example.com/feed.xml"  # optional, added to OPML
+++
```

### Creating content with w2z

[w2z](https://github.com/philipcristiano/w2z) can create notes, likes, replies, and recommendations from the command line using the templates in `w2z.toml`.

### Getting the current UTC datetime

```sh
date -u '+%Y-%m-%dT%H:%M:%SZ'
```

## Feeds

- `/atom.xml` — all content
- `/posts/atom.xml` — posts only
- `/notes/atom.xml` — notes only
- `/recommendations/opml` — recommendations as OPML (blogroll)

## IndieWeb

The site implements:
- **Microformats2**: `h-card` on homepage, `h-entry` + `h-feed` on all content types; `u-like-of`, `u-in-reply-to`, `u-bookmark-of`, `u-photo` on the relevant types
- **Webmentions**: sent on deploy via GitHub Actions; received via [webmention.io](https://webmention.io)
- **rel-me**: GitHub identity verification in `<head>`
- **ActivityPub bridge**: `/.well-known/host-meta` and `/webfinger` proxy to [fed.brid.gy](https://fed.brid.gy)

## Templates and styles

CSS and JS are vendored directly — no build step for styles.

- `static/main.css` — all styles: IBM Plex Sans font-face declarations, CSS custom properties (light/dark), custom feed card styles, compiled Serene base CSS
- `static/js/main.js` — theme toggle, copy buttons, back-to-top; vendored from [Serene](https://github.com/isunjn/serene)
- `templates/` — Tera templates; `_base.html` is the root layout
- `static/giallo-light.css` / `static/giallo-dark.css` — syntax highlighting themes

### Color scheme

Custom blue-gray palette, WCAG 2.1 AA compliant (all text/link colors ≥ 4.5:1):

| Token | Light | Dark |
|-------|-------|------|
| `--bg-color` | `#F5F4F0` | `#262626` |
| `--text-color` | `#2f3030` | `#C8C8C8` |
| `--text-pale-color` | `#666666` | `#939393` |
| `--text-decoration-color` | `#a9a9a9` | `#636363` |
| `--primary-color` | `#5570A2` | `#6f8fd1` |
| `--link-color` | `#205EA6` | `#6F8FD1` |
| `--visited-color` | `#5E409D` | `#9D91D0` |
| `--callout-note-color` | `#5570A2` | `#6f8fd1` |
| `--callout-tip-color` | `#1F7A45` | `#4A9C6E` |
| `--callout-important-color` | `#7A52B8` | `#A07FD6` |
| `--callout-warning-color` | `#A06030` | `#B8865C` |
| `--callout-caution-color` | `#BE4848` | `#DC7070` |
