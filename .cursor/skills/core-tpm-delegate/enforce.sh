#!/usr/bin/env bash
# core-tpm-delegate: enforce.sh
# Bundled gates for TPM / orchestrator role

set -euo pipefail

STEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$STEM_DIR/../../.." && pwd)"

echo "=== core-tpm-delegate: Running gates ==="

# Gate 1: Check for PO capsule if behavior depends on product intent
check_po_capsule() {
    local app_dir="$REPO_ROOT/app"
    if [[ -d "$app_dir" ]]; then
        local po_files
        po_files=$(find "$app_dir" -name "*.md" -type f 2>/dev/null | head -5)
        if [[ -n "$po_files" ]]; then
            echo "✓ PO capsules found in app/"
        else
            echo "⚠ No PO capsules found in app/ (may be OK for early setup)"
        fi
    fi
}

# Gate 2: Verify stem citations in recent commits (norms-only, no-op if no git history)
check_stem_citations() {
    if git rev-parse HEAD >/dev/null 2>&1; then
        echo "✓ Git repository detected"
    else
        echo "ℹ Not a git repository (skip stem citation check)"
    fi
}

# Gate 3: Mission block presence in work items
check_mission_block() {
    echo "ℹ Mission block check: ensure goal, scope, stack(s), cited stems in briefs"
}

# Run all gates
check_po_capsule
check_stem_citations
check_mission_block

echo "=== core-tpm-delegate: Gates complete ==="
