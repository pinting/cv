# Curriculum Vitae

My CV.

```bash
# Dependencies (Arch Linux)
sudo pacman -S make python-weasyprint ttf-liberation gnu-free-fonts

# Build
make
```

### Font & Styling Parameters

The PDF build uses `fonts.conf` via `FONTCONFIG_FILE` in the `Makefile` and explicit print font families in `index.html` to ensure deterministic rendering across different host systems and distributions without relying on system-default font priorities (such as `ttf-dejavu` or `noto-fonts` taking precedence over `gnu-free-fonts`).

Required font packages:
- `gnu-free-fonts` (provides **FreeSans** for body text and **FreeMono** for code blocks)
- `ttf-liberation` (provides **Liberation Mono** for headings)
