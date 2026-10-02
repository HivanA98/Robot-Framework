*** Settings ***
Documentation     Booking appointments across every facility / program combination.

Resource          ../pages/Cura.resource

Suite Setup       Start Cura Suite
Suite Teardown    Close Application
Test Setup        Start Logged In Test

Test Tags         appointment


*** Test Cases ***
Book Appointment Combination
    [Documentation]    Data-driven matrix: 3 facilities x 3 programs, readmission alternating.
    [Tags]    e2e
    [Template]    Booking Should Be Confirmed
    # facility    readmission    program
    ${TOKYO}    ${True}    Medicare
    ${TOKYO}    ${False}    Medicaid
    ${TOKYO}    ${True}    None
    ${HONGKONG}    ${False}    Medicare
    ${HONGKONG}    ${True}    Medicaid
    ${HONGKONG}    ${False}    None
    ${SEOUL}    ${True}    Medicare
    ${SEOUL}    ${False}    Medicaid
    ${SEOUL}    ${True}    None

Book Appointment With Defaults
    [Tags]    smoke    e2e
    Book And Verify Appointment    ${TOKYO}    ${False}    Medicare

Visit Date Is Mandatory
    [Tags]    negative
    Select Facility    ${SEOUL}
    Book Appointment
    Visit Date Should Be Required

Go To Homepage From Confirmation
    Book And Verify Appointment    ${HONGKONG}    ${True}    Medicaid
    Click When Ready    link:Go to Homepage
    Wait Until Element Is Visible    ${HOME_MAKE_APPOINTMENT}


*** Keywords ***
Booking Should Be Confirmed
    [Arguments]    ${facility}    ${readmission}    ${program}
    Start Logged In Test
    ${days}    Evaluate    random.randint(1, 60)
    Book And Verify Appointment    ${facility}    ${readmission}    ${program}    ${days}
