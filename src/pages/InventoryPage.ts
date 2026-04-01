import { Page, Locator } from '@playwright/test';

export class InventoryPage {
  private readonly addToCartButton: Locator;
  private readonly cartLink: Locator;

  constructor(private readonly page: Page) {
    this.addToCartButton = page.getByRole('button', { name: 'Add to cart' }).first();
    this.cartLink        = page.locator('[data-test="shopping-cart-link"]');
  }

  async isOnInventoryPage(): Promise<boolean> {
    return this.page.url().includes('/inventory.html');
  }

  async addFirstProductToCart(): Promise<void> {
    await this.addToCartButton.click();
  }

  async goToCart(): Promise<void> {
    await this.cartLink.click();
  }
}
