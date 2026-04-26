# Monorepo Repository

Thin intent hub following the four-plane architecture: **PO**, **Portable law**, **Ops**, and **Code**.

## Structure

```
.
├── .cursor/
│   ├── rules/           # Repository entry (agents-entry.mdc - always-on)
│   └── skills/          # Portable law stems (core-*)
├── app/                 # PO capsules (product intent, RouteName-first)
├── servers/
│   └── laravel/         # Laravel backend stack
├── clients/             # Frontend stacks (web, mobile, etc.)
├── k8s/                 # Kubernetes operations
└── tests/               # Playwright E2E tests
```

## Commands

```bash
./mono help              # Show all commands
./mono build [all|backend|frontend]
./mono dev [both|backend|frontend]
./mono test [all|backend|frontend|e2e]
./mono enforce [help|known-states|structure|po-capsules]
./mono clean
```

## Non-negotiables

- No upward Markdown links from `app/` to `.cursor/skills/`, `servers/`, or `clients/`
- No `.cursor/skills/` imports into product code
- One stack per change unless brief explicitly splits work
- Cite stem ids/slugs in prose

## Getting Started

1. Start Laravel backend: `./mono dev backend`
2. Run tests: `./mono test all`
3. Enforce portable law: `./mono enforce structure`
