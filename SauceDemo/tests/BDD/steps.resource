*** Comments ***
# Gherkin steps are written as natural sentences, not Title Case.
# robocop: off=wrong-case-in-keyword-name


*** Settings ***
Documentation    Gherkin step definitions. Every step delegates to a page object,
...              so BDD and TDD suites share the exact same implementation.

Resource         ../../pages/SauceDemo.resource


*** Keywords ***
# ---------------------------------------------------------------- Given
the user is on the SauceDemo login page
    Reset SauceDemo

the user is logged in as "${username}"
    Reset SauceDemo
    Login As    ${username}    ${PASSWORD}
    Inventory Page Should Be Open

# ---------------------------------------------------------------- When

the user logs in with username "${username}" and password "${password}"
    Login As    ${username}    ${password}

the user adds "${product}" to the cart
    Add Product To Cart    ${product}

the user checks out with random customer data
    Open Cart
    Checkout Cart With Random Customer

the user finishes the order
    Finish Checkout

the user sorts the products by "${option}"
    Sort Products By    ${option}

# ---------------------------------------------------------------- Then

the products page is displayed
    Inventory Page Should Be Open

the error "${message}" is displayed
    Login Error Should Be    ${message}

the cart badge shows ${count}
    Cart Badge Should Show    ${count}

the order totals are calculated correctly
    Order Totals Should Be Correct

the order is confirmed
    Order Should Be Complete

the product prices are in ${order} order
    ${prices}    Get Product Prices
    List Should Be Sorted    ${prices}    ${order}    numeric=True
