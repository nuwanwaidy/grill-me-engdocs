# =============================================================================
# Makefile — grill-me-engdocs skill packaging
# =============================================================================
# Usage:
#   make skill          Build the Claude skill zip (excludes dev-only content)
#   make skill-clean    Remove the build artefact
#
# The skill zip contains only what Claude needs at runtime.
# docs/, tests/, .git/ are excluded — dev-only content.
# surveys/ IS included — rating-template.xlsx is used by Claude at runtime.
#
# Output: dist/grill-me-engdocs.zip
# Stable download URL (once committed to main):
#   https://github.com/nuwanwaidya/grill-me-engdocs/raw/main/dist/grill-me-engdocs.zip
# =============================================================================

SKILL_NAME  := grill-me-engdocs
OUTPUT_DIR  := dist
SKILL_ZIP   := $(OUTPUT_DIR)/$(SKILL_NAME).zip

.PHONY: skill skill-clean

skill:
	@mkdir -p $(OUTPUT_DIR)
	@rm -f $(SKILL_ZIP)
	@zip -r $(SKILL_ZIP) \
		SKILL.md \
		config.yml \
		_context/ \
		modes/ \
		surveys/ \
		--exclude "*.gitkeep" \
		--exclude "*/.DS_Store" \
		--exclude "__MACOSX/*"
	@echo ""
	@echo "Built: $(SKILL_ZIP)"
	@echo "Contents:"
	@unzip -l $(SKILL_ZIP) | awk '{print $$NF}' | grep "\S" | sort

skill-clean:
	@rm -f $(SKILL_ZIP)
	@echo "Removed $(SKILL_ZIP)"