*** Settings ***
Library    SeleniumLibrary
Variables    resource.py

*** Keywords ***
Before All
    open browser    ${URL}   Chrome

Appointment
    Element Should Be Enabled    ${BtnAppointment}
    Click Element    ${BtnAppointment}