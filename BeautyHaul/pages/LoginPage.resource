*** Settings ***
Documentation    Page Object: BeautyHaul e-mail login (``/account/login``).

Resource         ../../resources/common.resource
Resource         FormValidation.resource
Variables        ../data/beautyhaul_data.py


*** Variables ***
${LOGIN_FORM_ID}            loginForm
${LOGIN_EMAIL}              css:#loginForm input[name="email"]
${LOGIN_PASSWORD}           css:#loginForm input[name="password"]
${LOGIN_TOGGLE_PASSWORD}    css:#loginForm button[type="button"]
${LOGIN_SUBMIT}             css:#loginForm button:not([type="button"])
${LOGIN_FORGOT_LINK}        css:#loginForm a[href="${FORGOT_PASSWORD_PATH}"]
${LOGIN_PHONE_LINK}         css:#loginForm a[href="${PHONE_LOGIN_PATH}"]
${LOGIN_GOOGLE}             id:googleSignInBtn
${LOGIN_HEADING_LOCATOR}    xpath://h1[normalize-space()="${LOGIN_HEADING}"]


*** Keywords ***
Open Login Page
    Go To    ${LOGIN_URL}
    Login Page Should Be Open

Login Page Should Be Open
    Wait Until Element Is Visible    ${LOGIN_HEADING_LOCATOR}
    Wait Until Element Is Visible    ${LOGIN_SUBMIT}

Login Form Should Be Complete
    FOR    ${locator}    IN    ${LOGIN_EMAIL}    ${LOGIN_PASSWORD}    ${LOGIN_SUBMIT}
    ...    ${LOGIN_FORGOT_LINK}    ${LOGIN_PHONE_LINK}    ${LOGIN_GOOGLE}
        Element Should Be Visible    ${locator}
    END

Fill Login Form
    [Arguments]    ${email}    ${password}
    IF    $email    Type When Ready    ${LOGIN_EMAIL}    ${email}
    IF    $password    Secret When Ready    ${LOGIN_PASSWORD}    ${password}

Submit Login Form
    Click When Ready    ${LOGIN_SUBMIT}

Login Error Should Be Shown
    [Arguments]    @{messages}
    Field Errors Should Be Shown    ${LOGIN_FORM_ID}    @{messages}

Toggle Password Visibility
    Click When Ready    ${LOGIN_TOGGLE_PASSWORD}

Password Field Type Should Be
    [Arguments]    ${expected}
    Wait Until Keyword Succeeds    5x    200ms
    ...    Element Attribute Value Should Be    ${LOGIN_PASSWORD}    type    ${expected}

Open Forgot Password
    Click When Ready    ${LOGIN_FORGOT_LINK}
    Wait Until Location Contains    ${FORGOT_PASSWORD_PATH}

Open Phone Login
    Click When Ready    ${LOGIN_PHONE_LINK}
    Wait Until Location Contains    ${PHONE_LOGIN_PATH}
