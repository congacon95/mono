# Skills Index

**Role → first skill** — pick your stance, open the linked stem.

| Role / Stance | Primary Skill | Purpose |
|---------------|---------------|---------|
| Stack implementer | **core-implement-slice** | Implement one product stack per brief |
| TPM / orchestrator | **core-tpm-delegate** | Intake, stems, briefs, verify chains (R1–R4b, V1–V5) |
| Review-only | **core-review-pr** | PR review, evidence, gates |
| Verify PR | **core-verify-pr** | Merge verification, command bundles |
| PO author | **core-po-product-docs** | Product intent capsules, RouteName-first docs |
| Structure / naming | **core-structure-and-naming** | IDENTITY, routing, layout, isolation norms |
| Known states / Playwright | **core-known-states** | UI lifecycles, baselines, screenshot mapping |
| Ops / k8s | **core-ops-k8s** | Cluster verify, k8s/ changes |

## Portable stems

Every **`core-*`** folder contains:
- **`SKILL.md`** — normative prose + cited checks
- **`enforce.sh`** — bundled gates (or no-op if norms-only)

Run from repo root:
```bash
./mono enforce help     # list all stems
./mono enforce <stem>   # run a specific stem's gates
```

## Stem folders

- `core-tpm-delegate/` — Delivery chains, intake, orchestration
- `core-implement-slice/` — Single-stack implementation
- `core-review-pr/` — PR evidence, gates
- `core-verify-pr/` — Verification layers V1–V5
- `core-po-product-docs/` — PO capsule format, normative rules
- `core-structure-and-naming/` — structure.md, IDENTITY
- `core-known-states/` — RouteName::KNOWN_STATE, Playwright baselines
- `core-ops-k8s/` — Kubernetes operations
- `app-portable-recipes/` — Cross-cutting patterns beside code

## Non-negotiables

- No `.cursor/skills/` imports into product code (`servers/*`, `clients/*`)
- No cross-imports between `servers/*` ↔ `clients/*`
- Cite stem ids/slugs in prose — no upward Markdown links from PO or ops docs
- One stack per change unless brief explicitly splits work
