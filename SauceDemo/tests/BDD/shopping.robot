*** Comments ***
# Gherkin steps are written as natural sentences, not Title Case.
# robocop: off=wrong-case-in-keyword-call


*** Settings ***
Documentation     Feature: Shopping
...               As a logged-in customer I want to sort, pick and pay for products.

Resource          steps.resource

Suite Setup       Start SauceDemo Suite
Suite Teardown    Close Application

Test Tags         bdd    shopping


*** Test Cases ***
Scenario: Sort products by price
    Given the user is logged in as "standard_user"
    When the user sorts the products by "price_desc"
    Then the product prices are in desc order

Scenario: Buy two products
    [Tags]    e2e    smoke
    Given the user is logged in as "standard_user"
    When the user adds "Sauce Labs Backpack" to the cart
    And the user adds "Sauce Labs Onesie" to the cart
    Then the cart badge shows 2
    When the user checks out with random customer data
    Then the order totals are calculated correctly
    When the user finishes the order
    Then the order is confirmed
    And the cart badge shows 0
