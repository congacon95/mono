# core-tpm-delegate

**Role:** TPM / orchestrator — intake, stems, briefs, verify chains (R1–R4b, V1–V5)

## Purpose

Owns delivery workflow: **PO → TPM (stems + briefs) → implementer → review → churn**.

## Read + Verify Chains

### R1 — Intake
- Confirm PO capsule exists with intent, acceptance, RouteName, non-goals
- Identify stack(s) — prefer one stack per slice
- Cite relevant portable stems

### R2 — Brief Formation
- Split multi-stack work explicitly if needed
- Attach linked PO capsule + this hub
- List cited stems (ids/slugs, not matrices)

### R3 — Handoff
- Implementer reads: linked PO → IDENTITY (if naming matters) → cited stem prose
- Mission block required: goal, scope, stack(s), cited stems

### R4 — Verification Prep
- Define evidence requirements for PR
- Layer V1–V5 checks as scope dictates

### R4b — Ops Runbook
- Cluster verify when k8s/ changes
- Stack-specific ops verification

## Verify Layers (V1–V5)

| Layer | Focus |
|-------|-------|
| V1 | PO capsule completeness |
| V2 | Stem citation + portable law adherence |
| V3 | Single-stack isolation (no cross-imports) |
| V4 | Test evidence (Pest/Playwright baselines) |
| V5 | Ops/cluster verify (if applicable) |

## Workflow Commands

```bash
./mono enforce help              # list all stems
./mono enforce tpm-delegate      # run TPM gates
./mono check                     # scope-based verification
```

## Non-negotiables

- No PO anchor → stop
- One stack unless brief splits work
- Cite stems in prose — no pasted matrices
- Mission block before coding
