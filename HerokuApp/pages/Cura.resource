*** Settings ***
Documentation    Facade for CURA Healthcare: page objects + business flows.

Resource         HomePage.resource
Resource         LoginPage.resource
Resource         AppointmentPage.resource
Resource         HistoryPage.resource


*** Keywords ***
Start Cura Suite
    Open Application    ${BASE_URL}

Reset Cura
    Reset Browser State    ${BASE_URL}/
    Open Home Page

Start Logged In Test
    Reset Cura
    Click Make Appointment
    Login As Demo User
    Appointment Page Should Be Open

Book And Verify Appointment
    [Documentation]    Books an appointment ``days_ahead`` days from today and verifies
    ...    the confirmation page. Returns the visit date used.
    [Arguments]    ${facility}    ${readmission}    ${program}    ${days_ahead}=7
    ${date}    Date In Days    ${days_ahead}
    ${comment}    FakerLibrary.Sentence    nb_words=6
    Fill Appointment    ${facility}    ${readmission}    ${program}    ${date}    ${comment}
    Book Appointment
    Confirmation Should Show    ${facility}    ${readmission}    ${program}    ${date}    ${comment}
    RETURN    ${date}    ${comment}
