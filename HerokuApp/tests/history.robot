*** Settings ***
Documentation     Appointment history is per session and lists every booking.

Resource          ../pages/Cura.resource

Suite Setup       Start Cura Suite
Suite Teardown    Close Application
Test Setup        Start Logged In Test

Test Tags         history


*** Test Cases ***
New Session Has Empty History
    Navigate Via Menu    History
    History Page Should Be Open
    History Should Be Empty

Booked Appointments Appear In History
    [Tags]    e2e    smoke
    ${first_date}    ${first_comment}    Book And Verify Appointment    ${TOKYO}    ${True}    Medicare    3
    Navigate Via Menu    Home
    Click Make Appointment
    ${second_date}    ${second_comment}    Book And Verify Appointment    ${SEOUL}    ${False}    None    10
    Navigate Via Menu    History
    History Page Should Be Open
    History Should Contain Appointment    ${TOKYO}    Medicare    ${first_date}    ${first_comment}
    History Should Contain Appointment    ${SEOUL}    None    ${second_date}    ${second_comment}
