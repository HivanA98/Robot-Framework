*** Settings ***
Documentation     Authentication rules of SauceDemo.

Resource          ../../pages/SauceDemo.resource

Suite Setup       Start SauceDemo Suite
Suite Teardown    Close Application
Test Setup        Reset SauceDemo

Test Tags         login


*** Test Cases ***
Every Accepted User Can Login
    [Documentation]    Every non-locked demo account must reach the inventory.
    [Tags]    positive    smoke
    [Template]    Login Should Succeed
    FOR    ${username}    IN    @{ACCEPTED_USERS}
        ${username}
    END

Invalid Login Is Rejected
    [Tags]    negative
    [Template]    Login Should Fail With
    # username    password    expected error
    ${LOCKED_USER}    ${PASSWORD}    ${LOGIN_ERRORS}[locked]
    ${UNKNOWN_USER}    ${WRONG_PASSWORD}    ${LOGIN_ERRORS}[mismatch]
    ${STANDARD_USER}    ${WRONG_PASSWORD}    ${LOGIN_ERRORS}[mismatch]
    ${EMPTY}    ${PASSWORD}    ${LOGIN_ERRORS}[username_required]
    ${STANDARD_USER}    ${EMPTY}    ${LOGIN_ERRORS}[password_required]
    ${EMPTY}    ${EMPTY}    ${LOGIN_ERRORS}[username_required]

Error Message Can Be Dismissed
    [Tags]    negative
    Login As    ${LOCKED_USER}
    Login Error Should Be    ${LOGIN_ERRORS}[locked]
    Dismiss Login Error

Inventory Is Protected Without Session
    [Tags]    negative    security
    Go To    ${INVENTORY_URL}
    Login Error Should Be    ${LOGIN_ERRORS}[not_logged_in]

User Can Logout
    [Tags]    positive    smoke
    Login As Standard User
    Logout
    Login Page Should Be Open
    Go To    ${INVENTORY_URL}
    Login Error Should Be    ${LOGIN_ERRORS}[not_logged_in]


*** Keywords ***
Login Should Succeed
    [Arguments]    ${username}
    Reset SauceDemo
    Login As    ${username}    ${PASSWORD}
    Inventory Page Should Be Open

Login Should Fail With
    [Arguments]    ${username}    ${password}    ${expected_error}
    Reset SauceDemo
    Login As    ${username}    ${password}
    Login Error Should Be    ${expected_error}
    Location Should Be    ${BASE_URL}/
