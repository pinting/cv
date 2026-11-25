SRC              = index.html
TARGET           = index.pdf
ASSETS           = avatar.jpg
FONTS_CONF       = fonts.conf
WEASYPRINT      ?= weasyprint
WEASYPRINT_FLAGS = --optimize-images

.PHONY: all check-deps view $(TARGET)

all: $(TARGET)

check-deps:
	@command -v $(WEASYPRINT) >/dev/null 2>&1 || { \
		echo "Error: '$(WEASYPRINT)' was not found in PATH." >&2; \
		echo "Install with: sudo pacman -S python-weasyprint" >&2; \
		exit 1; \
	}
	@FONTCONFIG_FILE="$(CURDIR)/$(FONTS_CONF)" fc-list : family | grep -q "FreeSans" || { \
		echo "Error: 'FreeSans' font was not found." >&2; \
		echo "Install with: sudo pacman -S gnu-free-fonts" >&2; \
		exit 1; \
	}
	@FONTCONFIG_FILE="$(CURDIR)/$(FONTS_CONF)" fc-list : family | grep -q "Liberation Mono" || { \
		echo "Error: 'Liberation Mono' font was not found." >&2; \
		echo "Install with: sudo pacman -S ttf-liberation" >&2; \
		exit 1; \
	}

$(TARGET): $(SRC) $(ASSETS) $(FONTS_CONF) Makefile | check-deps
	FONTCONFIG_FILE="$(CURDIR)/$(FONTS_CONF)" $(WEASYPRINT) $(WEASYPRINT_FLAGS) $(SRC) $(TARGET)

view: $(TARGET)
	@if command -v xdg-open >/dev/null 2>&1; then \
		xdg-open $(TARGET); \
	elif command -v open >/dev/null 2>&1; then \
		open $(TARGET); \
	fi
