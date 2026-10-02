*** Settings ***
Documentation    Facade for SauceDemo: one import gives a suite every page object
...              plus business-level flows composed from them.

Resource         LoginPage.resource
Resource         HeaderComponent.resource
Resource         InventoryPage.resource
Resource         CartPage.resource
Resource         CheckoutPage.resource


*** Keywords ***
# ---------------------------------------------------------------- hooks
Start SauceDemo Suite
    Open Application    ${BASE_URL}

Reset SauceDemo
    [Documentation]    Fresh session per test without paying for a new browser.
    Reset Browser State    ${BASE_URL}
    Login Page Should Be Open

Start Logged In Test
    Reset SauceDemo
    Login As Standard User

# ---------------------------------------------------------------- flows

Login As Standard User
    Login As    ${STANDARD_USER}    ${PASSWORD}
    Inventory Page Should Be Open

Checkout Cart With Random Customer
    [Documentation]    Cart page -> overview page, using generated customer data.
    Proceed To Checkout
    Checkout Information Page Should Be Open
    Fill Random Customer Information
    Continue Checkout
    Checkout Overview Page Should Be Open

Purchase Products
    [Documentation]    Full happy path from the inventory page to the confirmation page.
    [Arguments]    @{products}
    ${count}    Get Length    ${products}
    Add Products To Cart    @{products}
    Cart Badge Should Show    ${count}
    Open Cart
    Cart Page Should Be Open
    Cart Should Contain Exactly    @{products}
    Checkout Cart With Random Customer
    Overview Should List    @{products}
    Order Totals Should Be Correct
    Finish Checkout
    Order Should Be Complete
    Cart Badge Should Show    0
