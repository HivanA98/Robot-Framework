*** Settings ***
Documentation     Product listing: catalogue, sorting and add/remove toggles.

Resource          ../../pages/SauceDemo.resource

Suite Setup       Start SauceDemo Suite
Suite Teardown    Close Application
Test Setup        Start Logged In Test

Test Tags         inventory


*** Test Cases ***
Catalogue Shows All Products
    [Tags]    smoke
    Product Count Should Be    6
    ${names}    Get Product Names
    Lists Should Be Equal    ${names}    ${ALL_PRODUCTS}    ignore_order=True

Products Can Be Sorted
    [Template]    Products Should Be Sorted By
    # option    attribute    order
    name_asc    name    asc
    name_desc    name    desc
    price_asc    price    asc
    price_desc    price    desc

Product Details Match Catalogue Price
    FOR    ${name}    IN    @{ALL_PRODUCTS}
        Open Product Details    ${name}
        Product Details Price Should Be    ${PRODUCT_PRICES}[${name}]
        Back To Products
    END

Add To Cart Button Toggles To Remove
    Add Product To Cart    ${BACKPACK}
    Product Button Should Say    ${BACKPACK}    Remove
    Cart Badge Should Show    1
    Remove Product From Inventory    ${BACKPACK}
    Product Button Should Say    ${BACKPACK}    Add to cart
    Cart Badge Should Show    0

Cart Badge Counts Every Product
    FOR    ${index}    ${name}    IN ENUMERATE    @{ALL_PRODUCTS}    start=1
        Add Product To Cart    ${name}
        Cart Badge Should Show    ${index}
    END

Reset App State Empties The Cart
    Add Products To Cart    ${BACKPACK}    ${ONESIE}
    Cart Badge Should Show    2
    Reset App State
    Cart Badge Should Show    0


*** Keywords ***
Products Should Be Sorted By
    [Arguments]    ${option}    ${attribute}    ${order}
    Sort Products By    ${option}
    IF    $attribute == 'price'
        ${values}    Get Product Prices
        List Should Be Sorted    ${values}    ${order}    numeric=True
    ELSE
        ${values}    Get Product Names
        List Should Be Sorted    ${values}    ${order}
    END
