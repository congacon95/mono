#!/usr/bin/env bash
# core-implement-slice: enforce.sh
# Bundled gates for stack implementer role

set -euo pipefail

STEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$STEM_DIR/../../.." && pwd)"

echo "=== core-implement-slice: Running gates ==="

# Gate 1: Check isolation - no .cursor/skills imports in product code
check_isolation() {
    local servers_dir="$REPO_ROOT/servers"
    local clients_dir="$REPO_ROOT/clients"
    local skills_dir="$REPO_ROOT/.cursor/skills"
    
    if [[ -d "$servers_dir" ]]; then
        if grep -r "\.cursor/skills" "$servers_dir" --include="*.php" --include="*.ts" --include="*.js" 2>/dev/null; then
            echo "❌ Found .cursor/skills imports in servers/"
            return 1
        fi
        echo "✓ No .cursor/skills imports in servers/"
    fi
    
    if [[ -d "$clients_dir" ]]; then
        if grep -r "\.cursor/skills" "$clients_dir" --include="*.php" --include="*.ts" --include="*.js" 2>/dev/null; then
            echo "❌ Found .cursor/skills imports in clients/"
            return 1
        fi
        echo "✓ No .cursor/skills imports in clients/"
    fi
}

# Gate 2: Check cross-imports between servers and clients
check_cross_imports() {
    local servers_dir="$REPO_ROOT/servers"
    local clients_dir="$REPO_ROOT/clients"
    
    if [[ -d "$servers_dir" ]] && [[ -d "$clients_dir" ]]; then
        if grep -r "servers/" "$clients_dir" --include="*.php" --include="*.ts" --include="*.js" 2>/dev/null | grep -v "node_modules"; then
            echo "⚠ Potential cross-imports from clients/ to servers/"
        else
            echo "✓ No cross-imports from clients/ to servers/"
        fi
        
        if grep -r "clients/" "$servers_dir" --include="*.php" --include="*.ts" --include="*.js" 2>/dev/null | grep -v "node_modules"; then
            echo "⚠ Potential cross-imports from servers/ to clients/"
        else
            echo "✓ No cross-imports from servers/ to clients/"
        fi
    fi
}

# Gate 3: Verify single stack discipline (norms-only check)
check_single_stack() {
    echo "ℹ Single stack check: ensure one product stack per PR unless brief splits work"
}

# Run all gates
check_isolation || true
check_cross_imports || true
check_single_stack

echo "=== core-implement-slice: Gates complete ==="
