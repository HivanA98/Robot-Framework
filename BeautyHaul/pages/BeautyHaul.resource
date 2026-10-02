*** Settings ***
Documentation    Facade for BeautyHaul page objects.

Resource         LoginPage.resource
Resource         RegisterPage.resource


*** Keywords ***
Start BeautyHaul Suite
    Open Application    ${BASE_URL}

Fresh Login Page
    Reset Browser State    ${LOGIN_URL}
    Login Page Should Be Open

Fresh Register Page
    Reset Browser State    ${REGISTER_URL}
    Open Register Page
