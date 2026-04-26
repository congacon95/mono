#!/usr/bin/env bash
# core-structure-and-naming: enforce.sh
# Bundled gates for structure and naming hygiene

set -euo pipefail

STEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$STEM_DIR/../../.." && pwd)"

echo "=== core-structure-and-naming: Running gates ==="

# Gate 1: Check directory structure exists
check_structure() {
    local dirs=(".cursor/rules" ".cursor/skills" "app" "servers" "clients" "k8s")
    local missing=()
    
    for dir in "${dirs[@]}"; do
        if [[ ! -d "$REPO_ROOT/$dir" ]]; then
            missing+=("$dir")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo "⚠ Missing directories: ${missing[*]}"
    else
        echo "✓ Required directory structure present"
    fi
}

# Gate 2: Check for upward links from PO capsules
check_upward_links() {
    local app_dir="$REPO_ROOT/app"
    
    if [[ -d "$app_dir" ]]; then
        # Look for markdown links going up to .cursor/skills or servers/clients
        if grep -r "\](.*\.cursor/skills" "$app_dir" --include="*.md" 2>/dev/null; then
            echo "⚠ Found upward links from app/ to .cursor/skills/"
        else
            echo "✓ No upward links from app/ to .cursor/skills/"
        fi
        
        if grep -r "\](.*servers/" "$app_dir" --include="*.md" 2>/dev/null; then
            echo "⚠ Found upward links from app/ to servers/"
        else
            echo "✓ No upward links from app/ to servers/"
        fi
        
        if grep -r "\](.*clients/" "$app_dir" --include="*.md" 2>/dev/null; then
            echo "⚠ Found upward links from app/ to clients/"
        else
            echo "✓ No upward links from app/ to clients/"
        fi
    else
        echo "ℹ app/ directory not found (skip upward link check)"
    fi
}

# Gate 3: Verify agents-entry.mdc exists
check_hub_doc() {
    if [[ -f "$REPO_ROOT/.cursor/rules/agents-entry.mdc" ]]; then
        echo "✓ Repository entry (agents-entry.mdc) present"
    else
        echo "❌ Missing repository entry: .cursor/rules/agents-entry.mdc"
        return 1
    fi
}

# Run all gates
check_structure
check_upward_links || true
check_hub_doc

echo "=== core-structure-and-naming: Gates complete ==="
