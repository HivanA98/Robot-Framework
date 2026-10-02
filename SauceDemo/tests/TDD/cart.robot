*** Settings ***
Documentation     Shopping cart behaviour.

Resource          ../../pages/SauceDemo.resource

Suite Setup       Start SauceDemo Suite
Suite Teardown    Close Application
Test Setup        Start Logged In Test

Test Tags         cart


*** Test Cases ***
Empty Cart Shows No Items
    Open Cart
    Cart Page Should Be Open
    Cart Should Contain Exactly

Added Products Appear In Cart
    [Tags]    smoke
    Add Products To Cart    ${BACKPACK}    ${BIKE_LIGHT}    ${RED_TSHIRT}
    Open Cart
    Cart Page Should Be Open
    Cart Should Contain Exactly    ${BACKPACK}    ${BIKE_LIGHT}    ${RED_TSHIRT}

Product Can Be Removed From Cart
    Add Products To Cart    ${BACKPACK}    ${ONESIE}
    Open Cart
    Remove Product From Cart    ${BACKPACK}
    Cart Should Contain Exactly    ${ONESIE}
    Cart Badge Should Show    1

Cart Survives Continue Shopping
    Add Product To Cart    ${FLEECE_JACKET}
    Open Cart
    Continue Shopping
    Inventory Page Should Be Open
    Add Product To Cart    ${BOLT_TSHIRT}
    Open Cart
    Cart Should Contain Exactly    ${FLEECE_JACKET}    ${BOLT_TSHIRT}

Cart Survives Logout And Login
    [Documentation]    The cart lives in localStorage, so it is kept across sessions.
    Add Products To Cart    ${BACKPACK}    ${BIKE_LIGHT}
    Logout
    Login As Standard User
    Cart Badge Should Show    2
