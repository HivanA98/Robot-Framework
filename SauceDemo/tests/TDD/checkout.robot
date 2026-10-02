*** Settings ***
Documentation     End-to-end purchases and checkout form validation.

Resource          ../../pages/SauceDemo.resource

Suite Setup       Start SauceDemo Suite
Suite Teardown    Close Application
Test Setup        Start Logged In Test

Test Tags         checkout


*** Test Cases ***
E2E Single Order
    [Tags]    e2e    smoke
    Purchase Products    ${BACKPACK}

E2E Double Order
    [Tags]    e2e
    Purchase Products    ${BACKPACK}    ${BIKE_LIGHT}

E2E Triple Order
    [Tags]    e2e
    Purchase Products    ${BACKPACK}    ${BIKE_LIGHT}    ${BOLT_TSHIRT}

E2E Whole Catalogue
    [Tags]    e2e
    Purchase Products    @{ALL_PRODUCTS}

Back Home After Order Resets The Shop
    [Tags]    e2e
    Purchase Products    ${ONESIE}
    Back Home
    Inventory Page Should Be Open
    Product Button Should Say    ${ONESIE}    Add to cart

Customer Information Is Mandatory
    [Tags]    negative
    [Template]    Checkout Should Reject
    # first name    last name    postal code    expected error
    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${CHECKOUT_ERRORS}[first_name]
    ${EMPTY}    Armadi    20250    ${CHECKOUT_ERRORS}[first_name]
    Ivan    ${EMPTY}    20250    ${CHECKOUT_ERRORS}[last_name]
    Ivan    Armadi    ${EMPTY}    ${CHECKOUT_ERRORS}[postal_code]

Cancel On Information Step Returns To Cart
    Add Product To Cart    ${BACKPACK}
    Open Cart
    Proceed To Checkout
    Cancel Checkout
    Cart Page Should Be Open
    Cart Should Contain Exactly    ${BACKPACK}

Cancel On Overview Keeps The Cart
    Add Product To Cart    ${BIKE_LIGHT}
    Open Cart
    Checkout Cart With Random Customer
    Cancel Checkout
    Inventory Page Should Be Open
    Cart Badge Should Show    1


*** Keywords ***
Checkout Should Reject
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}    ${expected_error}
    Start Logged In Test
    Add Product To Cart    ${BACKPACK}
    Open Cart
    Proceed To Checkout
    Fill Customer Information    ${first_name}    ${last_name}    ${postal_code}
    Continue Checkout
    Checkout Error Should Be    ${expected_error}
    Checkout Information Page Should Be Open
