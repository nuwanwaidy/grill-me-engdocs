# =============================================================================
# Makefile — grill-me-engdocs skill packaging
# =============================================================================
# Usage:
#   make skill          Build the Claude skill zip (excludes dev-only content)
#   make skill-clean    Remove the build artefact
#
# The skill zip contains only what Claude needs at runtime.
# docs/, tests/, .git/, and surveys/ are excluded — dev-only content.
# =============================================================================

SKILL_NAME  := grill-me-engdocs
OUTPUT_DIR  := dist
SKILL_ZIP   := $(OUTPUT_DIR)/$(SKILL_NAME).zip

# Files and folders included in the skill zip
SKILL_INCLUDES := \
	SKILL.md \
	config.yml \
	_context/ \
	modes/

# Files and folders excluded (dev-only — not needed by Claude at runtime)
SKILL_EXCLUDES := \
	docs/ \
	tests/ \
	surveys/ \
	dist/ \
	.git/ \
	.gitignore \
	Makefile \
	README.md

.PHONY: skill skill-clean

skill:
	@mkdir -p $(OUTPUT_DIR)
	@rm -f $(SKILL_ZIP)
	@zip -r $(SKILL_ZIP) $(SKILL_INCLUDES) \
		$(foreach excl,$(SKILL_EXCLUDES),--exclude "$(excl)*") \
		--exclude "*.gitkeep" \
		--exclude "*/.DS_Store"
	@echo ""
	@echo "Built: $(SKILL_ZIP)"
	@echo "Contents:"
	@unzip -l $(SKILL_ZIP) | grep -v "^Archive" | grep -v "^\-\-" | awk '{print $$NF}' | sort

skill-clean:
	@rm -f $(SKILL_ZIP)
	@echo "Removed $(SKILL_ZIP)"
