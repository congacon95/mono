import { test, expect } from '@playwright/test';

test('capture homepage screenshot', async ({ page }) => {
  // Navigate to the home page
  await page.goto('/');
  
  // Take a screenshot
  await page.screenshot({ path: 'homepage-screenshot.png', fullPage: true });
  
  // Verify the page loaded successfully
  await expect(page).toHaveTitle(/Example Domain/);
  
  console.log('Screenshot captured successfully!');
});
