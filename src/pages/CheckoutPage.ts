import { Page } from '@playwright/test';

export class CheckoutPage {
  private readonly firstNameInput = '[data-test="firstName"]';
  private readonly lastNameInput = '[data-test="lastName"]';
  private readonly postalCodeInput = '[data-test="postalCode"]';
  private readonly continueButton = '[data-test="continue"]';
  private readonly finishButton = '[data-test="finish"]';
  private readonly confirmationHeader = '[data-test="complete-header"]';

  constructor(private readonly page: Page) {}

  async fillCheckoutInfo(
    firstName: string,
    lastName: string,
    postalCode: string
  ): Promise<void> {
    await this.page.fill(this.firstNameInput, firstName);
    await this.page.fill(this.lastNameInput, lastName);
    await this.page.fill(this.postalCodeInput, postalCode);
    await this.page.click(this.continueButton);
  }

  async completeOrder(): Promise<void> {
    await this.page.click(this.finishButton);
  }

  async getConfirmationMessage(): Promise<string> {
    return (await this.page.locator(this.confirmationHeader).textContent()) ?? '';
  }
}
