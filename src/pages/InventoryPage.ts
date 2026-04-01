import { Page } from '@playwright/test';

export class InventoryPage {
  private readonly addToCartButton = '[data-test^="add-to-cart"]';
  private readonly cartLink = '[data-test="shopping-cart-link"]';

  constructor(private readonly page: Page) {}

  async isOnInventoryPage(): Promise<boolean> {
    return this.page.url().includes('/inventory.html');
  }

  async addFirstProductToCart(): Promise<void> {
    await this.page.locator(this.addToCartButton).first().click();
  }

  async goToCart(): Promise<void> {
    await this.page.click(this.cartLink);
  }
}
