SRC              = index.html
TARGET           = index.pdf
ASSETS           = avatar.jpg
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

$(TARGET): $(SRC) $(ASSETS) Makefile | check-deps
	$(WEASYPRINT) $(WEASYPRINT_FLAGS) $(SRC) $(TARGET)

view: $(TARGET)
	@if command -v xdg-open >/dev/null 2>&1; then \
		xdg-open $(TARGET); \
	elif command -v open >/dev/null 2>&1; then \
		open $(TARGET); \
	fi
