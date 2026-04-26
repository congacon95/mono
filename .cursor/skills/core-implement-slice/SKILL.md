# core-implement-slice

**Role:** Stack implementer — implement one product stack per brief

## Purpose

Execute single-stack changes with portable law citations, isolation guarantees, and minimal scope.

## Global Invariants

- **One stack** unless the brief explicitly splits work
- **Scope** = ticket + linked PO + cited stems — no drive-bys
- **Isolation:** no `.cursor/skills/` imports into product code; no cross-imports `servers/*` ↔ `clients/*`
- **Laravel first** for shared cross-stack surfaces unless PO names another lead
- **UI:** design system / primitives — no raw platform controls where a stem defines the pattern
- **Smallest change** — no extra files or helpers unless asked
- **No shims, placeholders, or half-measures** — complete slice or explicit multi-slice plan

## Read Order

1. **Linked PO** — intent, acceptance, RouteName, non-goals
2. **IDENTITY / structure.md** — if naming, routing, layout matters
3. **Cited stem prose** — normative rules, not just green checks
4. **Stack verify + ops runbook** — for your specific stack
5. **Prove via** contract / structure / portable batch / `./mono check`

## Implementation Steps

### 1. Mission Block
Define before coding:
```
Goal: <what>
Scope: <ticket + PO + stems>
Stack: <servers/* or clients/* — one only>
Cited Stems: <stem ids/slugs>
```

### 2. Verify PO Anchor
- No PO anchor → stop and request
- Confirm RouteName for UI surfaces
- Check known states (`core-known-states`)

### 3. Apply Portable Law
- Cite stems in code comments or PR description
- Run `./mono enforce <stem>` for relevant gates
- No ad-hoc route factories — use contract helpers

### 4. Isolation Check
- No imports from `.cursor/skills/` into product code
- No cross-stack imports (`servers/*` ↔ `clients/*`)
- Single product stack per PR

### 5. Evidence
- Tests co-located with code
- Playwright baselines for known states (`.desktop-en.png`)
- `RouteName::KNOWN_STATE` lifecycle bar for FeatureRoutes

## Workflow Commands

```bash
./mono enforce help                    # list all stems
./mono enforce implement-slice         # run implementation gates
./mono check                           # scope-based verification
```

## Non-negotiables

- No drive-by changes outside ticket + PO + cited stems
- Complete slice or explicit multi-slice plan — no half-measures
- Cite stems in prose/code — don't just run green checks
- One stack per PR unless brief splits work
