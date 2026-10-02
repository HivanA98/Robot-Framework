*** Settings ***
Documentation    Page Object: shopping cart (``/cart.html``).

Resource         ../../resources/common.resource
Resource         HeaderComponent.resource


*** Variables ***
${CART_ITEMS}           css:[data-test="inventory-item"]
${CART_ITEM_NAMES}      css:[data-test="inventory-item-name"]
${CART_ITEM_PRICES}     css:[data-test="inventory-item-price"]
${CART_CONTINUE}        css:[data-test="continue-shopping"]
${CART_CHECKOUT}        css:[data-test="checkout"]
${CART_ITEM_BY_NAME}    xpath://div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space()="{name}"]]


*** Keywords ***
Cart Page Should Be Open
    Wait Until Location Contains    cart.html
    Page Title Should Be    Your Cart

Cart Should Contain Exactly
    [Documentation]    Order-insensitive comparison of the cart content with ``names``.
    [Arguments]    @{names}
    ${count}    Get Length    ${names}
    IF    ${count} == 0
        Page Should Not Contain Element    ${CART_ITEMS}
        RETURN
    END
    ${actual}    Get Texts    ${CART_ITEM_NAMES}
    Lists Should Be Equal    ${actual}    ${names}    ignore_order=True

Remove Product From Cart
    [Arguments]    ${name}
    ${item}    Replace String    ${CART_ITEM_BY_NAME}    {name}    ${name}
    Click When Ready    ${item}//button
    Wait Until Page Does Not Contain Element    ${item}

Continue Shopping
    Click When Ready    ${CART_CONTINUE}

Proceed To Checkout
    Click When Ready    ${CART_CHECKOUT}
