*** Settings ***
Documentation     BeautyHaul login form - UI and client-side validation only.
...               No valid-format credentials are submitted (production site + reCAPTCHA).

Resource          ../pages/BeautyHaul.resource

Suite Setup       Start BeautyHaul Suite
Suite Teardown    Close Application
Test Setup        Fresh Login Page

Test Tags         login


*** Test Cases ***
Login Form Is Rendered
    [Tags]    smoke
    Login Form Should Be Complete

Empty Form Shows Required Errors
    [Tags]    negative
    Submit Login Form
    Login Error Should Be Shown    ${MSG}[email_required]    ${MSG}[password_required]

Missing Password Is Reported
    [Tags]    negative
    Fill Login Form    ivan@example.com    ${EMPTY}
    Submit Login Form
    Login Error Should Be Shown    ${MSG}[password_required]

Malformed Email Is Rejected
    [Tags]    negative
    [Template]    Email Should Be Rejected
    FOR    ${email}    IN    @{INVALID_EMAILS}
        ${email}
    END

Password Visibility Can Be Toggled
    Fill Login Form    ${EMPTY}    Secret123
    Password Field Type Should Be    password
    Toggle Password Visibility
    Password Field Type Should Be    text
    Toggle Password Visibility
    Password Field Type Should Be    password

Helper Links Navigate
    [Template]    Helper Link Should Open
    Open Forgot Password
    Open Phone Login


*** Keywords ***
Email Should Be Rejected
    [Arguments]    ${email}
    Fresh Login Page
    Fill Login Form    ${email}    Secret123
    Submit Login Form
    Login Error Should Be Shown    ${MSG}[email_format]
    Location Should Be    ${LOGIN_URL}

Helper Link Should Open
    [Arguments]    ${navigation_keyword}
    Fresh Login Page
    Run Keyword    ${navigation_keyword}
