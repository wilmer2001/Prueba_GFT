import { Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world';
import { LoginPage } from '../pages/LoginPage';
import { InventoryPage } from '../pages/InventoryPage';
import { CartPage } from '../pages/CartPage';
import { CheckoutPage } from '../pages/CheckoutPage';

Given('I am on the SauceDemo login page', async function (this: CustomWorld) {
  const loginPage = new LoginPage(this.page);
  await loginPage.navigate();
});

When(
  'I login with username {string} and password {string}',
  async function (this: CustomWorld, username: string, password: string) {
    const loginPage = new LoginPage(this.page);
    await loginPage.login(username, password);
  }
);

Then('I should be on the inventory page', async function (this: CustomWorld) {
  // Manejo de redirección: SauceDemo redirige de / a /inventory.html
  await this.page.waitForURL('**/inventory.html');
  const inventoryPage = new InventoryPage(this.page);
  expect(await inventoryPage.isOnInventoryPage()).toBe(true);
});

Then(
  'I should see the error message {string}',
  async function (this: CustomWorld, expectedMessage: string) {
    const loginPage = new LoginPage(this.page);
    const errorMessage = await loginPage.getErrorMessage();
    expect(errorMessage).toContain(expectedMessage);
  }
);

When('I add the first product to the cart', async function (this: CustomWorld) {
  const inventoryPage = new InventoryPage(this.page);
  await inventoryPage.addFirstProductToCart();
});

When('I go to the cart', async function (this: CustomWorld) {
  const inventoryPage = new InventoryPage(this.page);
  await inventoryPage.goToCart();
});

When('I proceed to checkout', async function (this: CustomWorld) {
  const cartPage = new CartPage(this.page);
  await cartPage.proceedToCheckout();
});

When(
  'I fill checkout info with firstName {string} lastName {string} postalCode {string}',
  async function (
    this: CustomWorld,
    firstName: string,
    lastName: string,
    postalCode: string
  ) {
    const checkoutPage = new CheckoutPage(this.page);
    await checkoutPage.fillCheckoutInfo(firstName, lastName, postalCode);
  }
);

When('I complete the order', async function (this: CustomWorld) {
  const checkoutPage = new CheckoutPage(this.page);
  await checkoutPage.completeOrder();
});

Then('I should see the order confirmation', async function (this: CustomWorld) {
  const checkoutPage = new CheckoutPage(this.page);
  const message = await checkoutPage.getConfirmationMessage();
  expect(message).toContain('Thank you for your order!');
});
