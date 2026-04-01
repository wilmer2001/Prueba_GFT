import { Page } from '@playwright/test';

export class CartPage {
  private readonly checkoutButton = '[data-test="checkout"]';

  constructor(private readonly page: Page) {}

  async proceedToCheckout(): Promise<void> {
    await this.page.click(this.checkoutButton);
  }
}
