# core-known-states

**Role:** Known UI states / Playwright baselines — `RouteName::KNOWN_STATE`, screenshot mapping

## Purpose

Defines known UI states, lifecycles, and Playwright baseline expectations for shippable FeatureRoute surfaces.

## RouteName::KNOWN_STATE Lifecycle

Every shippable Laravel FeatureRoute surface must define:

```php
// In your FeatureRoute component or controller
class MyFeatureRoute
{
    public const KNOWN_STATE = [
        'initial' => 'Loading state before data fetch',
        'loaded' => 'Data loaded, primary content visible',
        'empty' => 'No data available, empty state shown',
        'error' => 'Error state with recovery options',
        'success' => 'Action completed successfully',
    ];
}
```

## Co-located Triple

Shippable surfaces require co-located artifacts:

1. **PO capsule** (`app/<Subsystem>/<Module>/feature.mdc`) — intent, acceptance, RouteName
2. **Tests** (Pest/Playwright) — expectations for each KNOWN_STATE
3. **Baselines** (`.desktop-en.png`) — Playwright screenshot baselines

```
app/MySubsystem/MyModule/
├── feature.mdc                 # PO capsule
├── MyFeatureRoute.php          # Implementation with KNOWN_STATE
├── MyFeatureRoute.spec.ts      # Playwright tests
└── baselines/
    └── MyFeatureRoute.desktop-en.png
```

## Playwright Baseline Expectations

### Screenshot Mapping

| State | Filename Pattern | Description |
|-------|------------------|-------------|
| Initial | `<RouteName>.initial.desktop-en.png` | Loading skeleton |
| Loaded | `<RouteName>.loaded.desktop-en.png` | Primary content |
| Empty | `<RouteName>.empty.desktop-en.png` | Empty state |
| Error | `<RouteName>.error.desktop-en.png` | Error state |
| Success | `<RouteName>.success.desktop-en.png` | Success confirmation |

### Test Structure

```typescript
import { test, expect } from '@playwright/test';

test('MyFeatureRoute: loaded state', async ({ page }) => {
  await page.goto('/my-feature');
  
  // Wait for known state
  await page.waitForSelector('[data-state="loaded"]');
  
  // Verify baseline
  await expect(page).toHaveScreenshot('MyFeatureRoute.loaded.desktop-en.png');
});
```

## Workflow Commands

```bash
./mono enforce known-states        # Run known-states gates
./mono check                       # Scope-based verification
```

## Inventory Gaps (Optional)

Run `inventory-po-capsule-gaps.php` to find missing co-located triples:

```bash
php .cursor/skills/core-known-states/inventory-po-capsule-gaps.php
```

## Non-negotiables

- Shippable FeatureRoute surfaces must have co-located triple (PO + tests + baselines)
- `RouteName::KNOWN_STATE` lifecycle bar required for all UI surfaces
- Playwright baselines (`.desktop-en.png`) for visual regression testing
- Artisan-only `extends Command` trees are out of scope for Inertia pairing
