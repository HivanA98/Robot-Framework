*** Settings ***
Documentation    Component Object: header + burger menu shared by every logged-in page.

Resource         ../../resources/common.resource


*** Variables ***
${HEADER_CART_LINK}     css:[data-test="shopping-cart-link"]
${HEADER_CART_BADGE}    css:[data-test="shopping-cart-badge"]
${HEADER_TITLE}         css:[data-test="title"]
${MENU_OPEN}            id:react-burger-menu-btn
${MENU_CLOSE}           id:react-burger-cross-btn
${MENU_ALL_ITEMS}       id:inventory_sidebar_link
${MENU_LOGOUT}          id:logout_sidebar_link
${MENU_RESET_STATE}     id:reset_sidebar_link


*** Keywords ***
Page Title Should Be
    [Arguments]    ${expected}
    Text Should Be    ${HEADER_TITLE}    ${expected}

Open Cart
    Click When Ready    ${HEADER_CART_LINK}

Cart Badge Should Show
    [Documentation]    ``0`` means the badge must not be rendered at all.
    [Arguments]    ${count}
    IF    ${count} == 0
        Page Should Not Contain Element    ${HEADER_CART_BADGE}
    ELSE
        Text Should Be    ${HEADER_CART_BADGE}    ${count}
    END

Open Menu
    Click When Ready    ${MENU_OPEN}
    Wait Until Element Is Visible    ${MENU_LOGOUT}

Choose Menu Item
    [Arguments]    ${item_locator}
    Open Menu
    Click When Ready    ${item_locator}

Logout
    Choose Menu Item    ${MENU_LOGOUT}

Reset App State
    Choose Menu Item    ${MENU_RESET_STATE}
    Click When Ready    ${MENU_CLOSE}
