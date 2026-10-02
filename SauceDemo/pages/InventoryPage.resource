*** Settings ***
Documentation    Page Object: product listing (``/inventory.html``).
...              Product cards are located by their visible name, so new products
...              need no new locator.

Resource         ../../resources/common.resource
Resource         HeaderComponent.resource
Variables        ../data/saucedemo_data.py


*** Variables ***
${INVENTORY_LIST}           css:[data-test="inventory-list"]
${INVENTORY_ITEM_NAMES}     css:[data-test="inventory-item-name"]
${INVENTORY_ITEM_PRICES}    css:[data-test="inventory-item-price"]
${SORT_DROPDOWN}            css:[data-test="product-sort-container"]
${DETAIL_NAME}              css:[data-test="inventory-item-name"]
${DETAIL_PRICE}             css:[data-test="inventory-item-price"]
${DETAIL_BACK}              css:[data-test="back-to-products"]
# ${name} is resolved when the template is used (see "Product Card Button").
${PRODUCT_CARD}             xpath://div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space()="{name}"]]


*** Keywords ***
Inventory Page Should Be Open
    Wait Until Location Contains    inventory.html
    Wait Until Element Is Visible    ${INVENTORY_LIST}
    Page Title Should Be    Products

Product Card Button
    [Documentation]    Locator of the Add/Remove button inside the card named ``name``.
    [Arguments]    ${name}
    ${card}    Replace String    ${PRODUCT_CARD}    {name}    ${name}
    RETURN    ${card}//button

Add Product To Cart
    [Arguments]    ${name}
    ${button}    Product Card Button    ${name}
    Element Text Should Be    ${button}    Add to cart
    Click When Ready    ${button}
    Wait Until Element Contains    ${button}    Remove

Add Products To Cart
    [Arguments]    @{names}
    FOR    ${name}    IN    @{names}
        Add Product To Cart    ${name}
    END

Remove Product From Inventory
    [Arguments]    ${name}
    ${button}    Product Card Button    ${name}
    Click When Ready    ${button}
    Wait Until Element Contains    ${button}    Add to cart

Product Button Should Say
    [Arguments]    ${name}    ${label}
    ${button}    Product Card Button    ${name}
    Text Should Be    ${button}    ${label}

Sort Products By
    [Documentation]    ``option`` is a key of ``SORT_OPTIONS`` (name_asc, name_desc, price_asc, price_desc).
    [Arguments]    ${option}
    Select From List By Value    ${SORT_DROPDOWN}    ${SORT_OPTIONS}[${option}]

Get Product Names
    ${names}    Get Texts    ${INVENTORY_ITEM_NAMES}
    RETURN    ${names}

Get Product Prices
    ${texts}    Get Texts    ${INVENTORY_ITEM_PRICES}
    ${prices}    Parse Prices    ${texts}
    RETURN    ${prices}

Product Count Should Be
    [Arguments]    ${expected}
    ${names}    Get Product Names
    Length Should Be    ${names}    ${expected}

Open Product Details
    [Arguments]    ${name}
    Click When Ready    xpath://div[@data-test="inventory-item-name" and normalize-space()="${name}"]
    Text Should Be    ${DETAIL_NAME}    ${name}

Product Details Price Should Be
    [Arguments]    ${expected}
    Text Should Be    ${DETAIL_PRICE}    $${expected}

Back To Products
    Click When Ready    ${DETAIL_BACK}
    Inventory Page Should Be Open
