*** Settings ***
Library    SeleniumLibrary
Variables    resource.py

*** Keywords ***
Before All
    open browser    ${URL}   Chrome

Appointment
    Element Should Be Enabled    ${BtnAppointment}
    Click Element    ${BtnAppointment}

Username
    Element Should Be Enabled    ${Username}
    Input Text    ${Username}    ${name}

Password
    Element Should Be Enabled    ${Password}
    Input Text    ${Password}    ${psw}