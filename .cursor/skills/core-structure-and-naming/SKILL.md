# core-structure-and-naming

**Role:** Naming / structure hygiene — IDENTITY, routing, layout, isolation norms

## Purpose

Defines product shape, naming conventions, routing patterns, and isolation boundaries.

## Product Shape at a Glance

| Plane | Location | Owner |
|-------|----------|-------|
| PO | `app/<Subsystem>/<Module>/` | Product intent capsules |
| Portable law | `.cursor/skills/core-*/` | Normative prose + gates |
| Ops | `k8s/` | Cluster configuration |
| Code | `servers/*`, `clients/*` | Product implementation |

## Normative Rules

### IDENTITY

- **RouteName-first**: All UI surfaces start with RouteName definition
- **FeatureRoute pattern**: Co-located PO + tests + `RouteName::KNOWN_STATE` lifecycle bar
- **No ad-hoc route factories**: Use contract helpers from cited stems

### Layout

```
repo-root/
├── .cursor/
│   ├── rules/              # Hub docs (agents-entry.mdc always-on)
│   └── skills/
│       ├── core-*/         # Portable law stems
│       │   ├── SKILL.md    # Normative prose
│       │   └── enforce.sh  # Bundled gates
│       └── app-portable-recipes/
├── app/                    # PO capsules
│   └── <Subsystem>/<Module>/
├── servers/                # Server stacks (one per PR)
├── clients/                # Client stacks (one per PR)
├── k8s/                    # Kubernetes configs
└── mono                    # CLI entry point
```

### Isolation

- No `.cursor/skills/` imports into `servers/*` or `clients/*`
- No cross-imports between `servers/*` ↔ `clients/*`
- One product stack per change unless brief splits work

### Routing

- Cite stems for routing patterns — no invented conventions
- Contract helpers over ad-hoc factories
- `RouteName::KNOWN_STATE` for UI lifecycles (see `core-known-states`)

## Doc Placement

| Content Type | Location | Links Allowed |
|--------------|----------|---------------|
| PO capsules | `app/**` | No upward links to skills/code |
| Skill stems | `.cursor/skills/core-*/` | Cite by stem id/slug |
| Ops docs | `k8s/` | No upward links to skills |
| Feature docs | Beside code | Cite stems, don't link up |

## Workflow Commands

```bash
./mono enforce structure           # Run structure/naming gates
./mono check                       # Scope-based verification
```

## Non-negotiables

- RouteName-first for all UI surfaces
- No upward Markdown links from PO, k8s/, or editor config into skill trees
- Cite stem ids/slugs in prose — don't paste stem matrices
- Normalize from this stem before coding if naming/routing/layout matters
