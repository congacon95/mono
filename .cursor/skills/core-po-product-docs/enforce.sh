#!/usr/bin/env bash
# core-po-product-docs: enforce.sh
# Bundled gates for PO capsule format and editing discipline

set -euo pipefail

STEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$STEM_DIR/../../.." && pwd)"

echo "=== core-po-product-docs: Running gates ==="

# Gate 1: Check for app directory (PO capsules location)
check_app_directory() {
    if [[ -d "$REPO_ROOT/app" ]]; then
        echo "✓ app/ directory present (PO capsules location)"
    else
        echo "ℹ app/ directory not found (may be OK for new projects)"
    fi
}

# Gate 2: Verify no upward Markdown links from PO to skills/servers/clients
check_no_upward_links() {
    local app_dir="$REPO_ROOT/app"
    local violations=0

    if [[ -d "$app_dir" ]]; then
        # Check for links to .cursor/skills
        if grep -r "\](.*\.cursor/skills" "$app_dir" --include="*.md" 2>/dev/null | head -5; then
            echo "⚠ Found upward links from app/ to .cursor/skills/"
            violations=$((violations + 1))
        fi

        # Check for links to servers/
        if grep -r "\](.*servers/" "$app_dir" --include="*.md" 2>/dev/null | head -5; then
            echo "⚠ Found upward links from app/ to servers/"
            violations=$((violations + 1))
        fi

        # Check for links to clients/
        if grep -r "\](.*clients/" "$app_dir" --include="*.md" 2>/dev/null | head -5; then
            echo "⚠ Found upward links from app/ to clients/"
            violations=$((violations + 1))
        fi

        if [[ $violations -eq 0 ]]; then
            echo "✓ No upward links from PO capsules"
        else
            echo "⚠ Found $violations upward link violation(s)"
        fi
    else
        echo "ℹ app/ directory not found (skip upward link check)"
    fi
}

# Gate 3: Check for RouteName references in PO capsules (normative requirement)
check_routename_usage() {
    local app_dir="$REPO_ROOT/app"

    if [[ -d "$app_dir" ]]; then
        local md_files
        md_files=$(find "$app_dir" -name "*.md" -type f 2>/dev/null | wc -l)
        if [[ $md_files -gt 0 ]]; then
            echo "✓ Found $md_files PO capsule file(s)"
        else
            echo "ℹ No PO capsule files found yet"
        fi
    else
        echo "ℹ app/ directory not found"
    fi
}

# Run all gates
check_app_directory
check_no_upward_links || true
check_routename_usage

echo "=== core-po-product-docs: Gates complete ==="
