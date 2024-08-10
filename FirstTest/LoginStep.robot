*** Settings ***
Library    SeleniumLibrary
Variables    Resource.py

*** Keywords ***
Login
    Open Browser    ${URL}   Chrome
    Input Text    ${InputName}   standard_user
    Input Text    ${InputPassword}   secret_sauce
    Click Button    ${BtnLogin}

Additem
    Click Button    ${PrtBackpack}