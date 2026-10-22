# Portfolio

Source for my public portfolio page — support and content samples written for
crypto products.

Single static file, no build step, no dependencies. Open `index.html` directly.

Deployed with GitHub Pages.

## Layout

- `index.html` — the portfolio page. Pixel / 8-bit console theme, plain CSS +
  vanilla JS, no frameworks and no trackers.
  - Boot screen on first visit (`PRESS START`), skipped on later visits.
  - Section tabs: profile, experience, skills, communities, contact.
  - Keyboard: `1`–`5` jump to a section, `←`/`→` move between tabs, `T` swaps
    the palette (arcade / pocket), `C` toggles CRT scanlines, `?` opens the
    controls panel, `Esc` closes it.
  - Preferences (palette, scanlines) persist in `localStorage`.
  - Respects `prefers-reduced-motion`.
- `cv.html` — print-optimised A4 version of the CV.
- `cv.pdf` — downloadable CV.

## Files

| File | Purpose |
| --- | --- |
| `index.html` | Main page |
| `cv.html` | Print / save-as-PDF view |
| `cv.pdf` | CV download |
