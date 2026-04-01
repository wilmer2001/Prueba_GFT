import { Page, Locator } from '@playwright/test';

export class CheckoutPage {
  private readonly firstNameInput: Locator;
  private readonly lastNameInput: Locator;
  private readonly postalCodeInput: Locator;
  private readonly continueButton: Locator;
  private readonly finishButton: Locator;
  private readonly confirmationHeader: Locator;

  constructor(private readonly page: Page) {
    this.firstNameInput      = page.getByPlaceholder('First Name');
    this.lastNameInput       = page.getByPlaceholder('Last Name');
    this.postalCodeInput     = page.getByPlaceholder('Zip/Postal Code');
    this.continueButton      = page.getByRole('button', { name: 'Continue' });
    this.finishButton        = page.getByRole('button', { name: 'Finish' });
    this.confirmationHeader  = page.locator('[data-test="complete-header"]');
  }

  async fillCheckoutInfo(
    firstName: string,
    lastName: string,
    postalCode: string
  ): Promise<void> {
    await this.firstNameInput.fill(firstName);
    await this.lastNameInput.fill(lastName);
    await this.postalCodeInput.fill(postalCode);
    await this.continueButton.click();
  }

  async completeOrder(): Promise<void> {
    await this.finishButton.click();
  }

  async getConfirmationMessage(): Promise<string> {
    return (await this.confirmationHeader.textContent()) ?? '';
  }
}
