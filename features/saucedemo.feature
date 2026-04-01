@regression
Feature: SauceDemo E2E Tests
  Automatización del flujo completo en SauceDemo: login, carrito y checkout.

  @smoke @critical
  Scenario: Happy Path - Login válido y checkout completo
    Given I am on the SauceDemo login page
    When I login with username "standard_user" and password "secret_sauce"
    Then I should be on the inventory page
    When I add the first product to the cart
    And I go to the cart
    And I proceed to checkout
    And I fill checkout info with firstName "John" lastName "Doe" postalCode "12345"
    And I complete the order
    Then I should see the order confirmation

  @negative @regression
  Scenario: Login Fallido - Usuario bloqueado
    Given I am on the SauceDemo login page
    When I login with username "locked_out_user" and password "secret_sauce"
    Then I should see the error message "Epic sadface: Sorry, this user has been locked out."

  @regression
  Scenario Outline: Data Driven - Login con múltiples usuarios
    Given I am on the SauceDemo login page
    When I login with username "<username>" and password "<password>"
    Then I should be on the inventory page

    Examples:
      | username                | password     |
      | standard_user           | secret_sauce |
      | problem_user            | secret_sauce |
      | performance_glitch_user | secret_sauce |
