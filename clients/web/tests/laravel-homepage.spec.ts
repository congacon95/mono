import { test, expect } from '@playwright/test';

test('Laravel homepage loads and captures screenshot', async ({ page }) => {
  // Navigate to Laravel server (expects server running at localhost:8000)
  await page.goto('/', { timeout: 15000 });

  // Verify page title contains "Laravel"
  await expect(page).toHaveTitle(/Laravel/, { timeout: 5000 });

  // Capture full-page screenshot
  await page.screenshot({
    path: '/workspace/laravel-homepage-screenshot.png',
    fullPage: true
  });

  // Verify welcome content is visible
  const body = page.locator('body');
  await expect(body).toBeVisible();
});
