*** Settings ***
Documentation    Page Object: voila.id sign-in (``/account/login``).
...              Locators rely on the site's own ``data-test-id`` hooks.

Resource         ../../resources/common.resource
Variables        ../data/voila_data.py


*** Variables ***
${VOILA_IDENTIFIER}       css:[data-test-id="CT_component_login_input"]
${VOILA_SIGN_IN}          css:[data-test-id="CT_component_login_submit"]
${VOILA_GOOGLE}           xpath://form//button[normalize-space()="Google"]
${VOILA_FACEBOOK}         xpath://form//button[normalize-space()="Facebook"]
${VOILA_REGISTER_LINK}    css:a[href="${REGISTER_PATH}"]


*** Keywords ***
Open Voila Login Page
    Reset Browser State    ${LOGIN_URL}
    Wait Until Element Is Visible    ${VOILA_IDENTIFIER}
    Title Should Start With    ${LOGIN_TITLE}

Title Should Start With
    [Arguments]    ${prefix}
    ${title}    Get Title
    Should Start With    ${title}    ${prefix}

Sign In Form Should Be Complete
    FOR    ${locator}    IN    ${VOILA_IDENTIFIER}    ${VOILA_SIGN_IN}    ${VOILA_GOOGLE}
    ...    ${VOILA_FACEBOOK}    ${VOILA_REGISTER_LINK}
        Element Should Be Visible    ${locator}
    END

Enter Identifier
    [Arguments]    ${identifier}
    Type When Ready    ${VOILA_IDENTIFIER}    ${identifier}

Clear Identifier
    [Documentation]    React ignores ``Clear Element Text``; delete key presses instead.
    Click Element    ${VOILA_IDENTIFIER}
    Press Keys    ${VOILA_IDENTIFIER}    CTRL+a    BACKSPACE

Sign In Button Should Be Disabled
    Wait Until Keyword Succeeds    5x    300ms    Element Should Be Disabled    ${VOILA_SIGN_IN}

Sign In Button Should Be Enabled
    Wait Until Element Is Enabled    ${VOILA_SIGN_IN}

Go To Register
    Click When Ready    ${VOILA_REGISTER_LINK}
    Wait Until Location Contains    ${REGISTER_PATH}
