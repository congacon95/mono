#!/usr/bin/env bash
# core-known-states: enforce.sh
# Bundled gates for known UI states and Playwright baselines

set -euo pipefail

STEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$STEM_DIR/../../.." && pwd)"

echo "=== core-known-states: Running gates ==="

# Gate 1: Check for Playwright config
check_playwright_config() {
    if [[ -f "$REPO_ROOT/playwright.config.ts" ]]; then
        echo "✓ Playwright configuration present"
    else
        echo "⚠ Missing playwright.config.ts"
    fi
}

# Gate 2: Check for test directory
check_tests_directory() {
    if [[ -d "$REPO_ROOT/tests" ]]; then
        local test_count
        test_count=$(find "$REPO_ROOT/tests" -name "*.spec.ts" -type f 2>/dev/null | wc -l)
        echo "✓ Tests directory found ($test_count spec files)"
    else
        echo "⚠ Missing tests/ directory"
    fi
}

# Gate 3: Check for screenshot baselines (norms-only)
check_baselines() {
    local baseline_count
    baseline_count=$(find "$REPO_ROOT" -name "*.desktop-en.png" -type f 2>/dev/null | wc -l)
    if [[ $baseline_count -gt 0 ]]; then
        echo "✓ Found $baseline_count Playwright baseline(s)"
    else
        echo "ℹ No .desktop-en.png baselines found (may be OK for new projects)"
    fi
}

# Gate 4: Verify homepage screenshot exists (from earlier setup)
check_homepage_screenshot() {
    if [[ -f "$REPO_ROOT/homepage-screenshot.png" ]]; then
        echo "✓ Homepage screenshot present"
    else
        echo "ℹ No homepage-screenshot.png found"
    fi
}

# Run all gates
check_playwright_config
check_tests_directory
check_baselines || true
check_homepage_screenshot || true

echo "=== core-known-states: Gates complete ==="
