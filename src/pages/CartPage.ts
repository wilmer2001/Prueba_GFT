import { Page, Locator } from '@playwright/test';

export class CartPage {
  private readonly checkoutButton: Locator;

  constructor(private readonly page: Page) {
    this.checkoutButton = page.getByRole('button', { name: 'Checkout' });
  }

  async proceedToCheckout(): Promise<void> {
    await this.checkoutButton.click();
  }
}
