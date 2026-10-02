*** Settings ***
Documentation    Page Object: the three checkout steps
...              (information -> overview -> complete).

Resource         ../../resources/common.resource
Resource         HeaderComponent.resource
Variables        ../data/saucedemo_data.py


*** Variables ***
# Step one: customer information
${CHECKOUT_FIRST_NAME}     css:[data-test="firstName"]
${CHECKOUT_LAST_NAME}      css:[data-test="lastName"]
${CHECKOUT_POSTAL_CODE}    css:[data-test="postalCode"]
${CHECKOUT_CONTINUE}       css:[data-test="continue"]
${CHECKOUT_CANCEL}         css:[data-test="cancel"]
${CHECKOUT_ERROR}          css:[data-test="error"]
# Step two: overview
${OVERVIEW_ITEM_NAMES}     css:[data-test="inventory-item-name"]
${OVERVIEW_ITEM_PRICES}    css:[data-test="inventory-item-price"]
${OVERVIEW_SUBTOTAL}       css:[data-test="subtotal-label"]
${OVERVIEW_TAX}            css:[data-test="tax-label"]
${OVERVIEW_TOTAL}          css:[data-test="total-label"]
${OVERVIEW_FINISH}         css:[data-test="finish"]
# Complete
${COMPLETE_HEADER}         css:[data-test="complete-header"]
${COMPLETE_BACK_HOME}      css:[data-test="back-to-products"]


*** Keywords ***
# ---------------------------------------------------------------- step one
Checkout Information Page Should Be Open
    Wait Until Location Contains    checkout-step-one.html
    Page Title Should Be    Checkout: Your Information

Fill Customer Information
    [Documentation]    Empty values are skipped, so missing-field scenarios reuse this keyword.
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    IF    $first_name
        Type When Ready    ${CHECKOUT_FIRST_NAME}    ${first_name}
    END
    IF    $last_name    Type When Ready    ${CHECKOUT_LAST_NAME}    ${last_name}
    IF    $postal_code
        Type When Ready    ${CHECKOUT_POSTAL_CODE}    ${postal_code}
    END

Fill Random Customer Information
    [Documentation]    Generates a realistic Indonesian customer with FakerLibrary.
    ${first}    FakerLibrary.First Name
    ${last}    FakerLibrary.Last Name
    ${postcode}    FakerLibrary.Postcode
    Fill Customer Information    ${first}    ${last}    ${postcode}

Continue Checkout
    Click When Ready    ${CHECKOUT_CONTINUE}

Cancel Checkout
    Click When Ready    ${CHECKOUT_CANCEL}

Checkout Error Should Be
    [Arguments]    ${expected}
    Text Should Be    ${CHECKOUT_ERROR}    ${expected}

# ---------------------------------------------------------------- step two

Checkout Overview Page Should Be Open
    Wait Until Location Contains    checkout-step-two.html
    Page Title Should Be    Checkout: Overview

Overview Should List
    [Arguments]    @{names}
    ${actual}    Get Texts    ${OVERVIEW_ITEM_NAMES}
    Lists Should Be Equal    ${actual}    ${names}    ignore_order=True

Order Totals Should Be Correct
    [Documentation]    Recomputes item total, tax (${TAX_RATE}) and grand total from the line items
    ...    and compares them with the summary shown by the shop.
    ${line_texts}    Get Texts    ${OVERVIEW_ITEM_PRICES}
    ${line_prices}    Parse Prices    ${line_texts}
    ${expected_subtotal}    Sum Prices    ${line_prices}
    ${expected_tax}    Calculate Tax    ${expected_subtotal}    ${TAX_RATE}
    ${expected_total}    Evaluate    $expected_subtotal + $expected_tax

    ${subtotal}    Get Text    ${OVERVIEW_SUBTOTAL}
    ${tax}    Get Text    ${OVERVIEW_TAX}
    ${total}    Get Text    ${OVERVIEW_TOTAL}
    ${subtotal}    Parse Price    ${subtotal}
    ${tax}    Parse Price    ${tax}
    ${total}    Parse Price    ${total}

    Should Be Equal    ${subtotal}    ${expected_subtotal}    Item total mismatch
    Should Be Equal    ${tax}    ${expected_tax}    Tax mismatch
    Should Be Equal    ${total}    ${expected_total}    Grand total mismatch
    RETURN    ${total}

Finish Checkout
    Click When Ready    ${OVERVIEW_FINISH}

# ---------------------------------------------------------------- complete

Order Should Be Complete
    Wait Until Location Contains    checkout-complete.html
    Text Should Be    ${COMPLETE_HEADER}    ${ORDER_COMPLETE_HEADER}

Back Home
    Click When Ready    ${COMPLETE_BACK_HOME}
