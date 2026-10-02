*** Settings ***
Documentation     CURA authentication.

Resource          ../pages/Cura.resource

Suite Setup       Start Cura Suite
Suite Teardown    Close Application
Test Setup        Reset Cura

Test Tags         login


*** Test Cases ***
Demo User Can Login From Make Appointment
    [Tags]    positive    smoke
    Click Make Appointment
    Login As Demo User
    Appointment Page Should Be Open

Invalid Credentials Are Rejected
    [Tags]    negative
    [Template]    Login Should Be Rejected
    # username    password
    ${DEMO_USERNAME}    WrongPassword
    Jane Doe    ${DEMO_PASSWORD}
    ${EMPTY}    ${EMPTY}
    john doe    ${DEMO_PASSWORD}

Menu Changes After Login And Logout
    [Tags]    positive
    Menu Should Offer    Home    Login
    Click Make Appointment
    Login As Demo User
    Menu Should Offer    Home    History    Profile    Logout
    Navigate Via Menu    Logout
    Open Home Page
    Menu Should Offer    Home    Login

History Requires Login
    [Documentation]    Anonymous visitors are redirected back to the landing page.
    [Tags]    negative    security
    Go To    ${BASE_URL}/history.php
    Location Should Be    ${BASE_URL}/
    Element Should Be Visible    ${HOME_MAKE_APPOINTMENT}


*** Keywords ***
Login Should Be Rejected
    [Arguments]    ${username}    ${password}
    Reset Cura
    Click Make Appointment
    Login With Credentials    ${username}    ${password}
    Login Should Have Failed
