*** Settings ***
Documentation    Page Object: SauceDemo login page (``/``).

Resource         ../../resources/common.resource
Variables        ../data/saucedemo_data.py


*** Variables ***
${LOGIN_USERNAME}       css:[data-test="username"]
${LOGIN_PASSWORD}       css:[data-test="password"]
${LOGIN_BUTTON}         css:[data-test="login-button"]
${LOGIN_ERROR}          css:[data-test="error"]
${LOGIN_ERROR_CLOSE}    css:[data-test="error-button"]
${LOGIN_LOGO}           class:login_logo


*** Keywords ***
Open Login Page
    Go To    ${BASE_URL}
    Login Page Should Be Open

Login Page Should Be Open
    Wait Until Element Is Visible    ${LOGIN_BUTTON}
    Element Should Be Visible    ${LOGIN_LOGO}

Enter Username
    [Arguments]    ${username}
    Type When Ready    ${LOGIN_USERNAME}    ${username}

Enter Password
    [Arguments]    ${password}
    Secret When Ready    ${LOGIN_PASSWORD}    ${password}

Submit Login
    Click When Ready    ${LOGIN_BUTTON}

Login As
    [Documentation]    Fill the form and submit. Empty values leave the field untouched.
    [Arguments]    ${username}    ${password}=${PASSWORD}
    IF    $username    Enter Username    ${username}
    IF    $password    Enter Password    ${password}
    Submit Login

Login Error Should Be
    [Arguments]    ${expected}
    Text Should Be    ${LOGIN_ERROR}    ${expected}

Dismiss Login Error
    Click When Ready    ${LOGIN_ERROR_CLOSE}
    Wait Until Element Is Not Visible    ${LOGIN_ERROR}
