*** Settings ***
Library    SeleniumLibrary
Variables    ..//Resource.py

*** Keywords ***
The user visit the website Saucedemo
    Open Browser    ${URL}   Chrome

The user enters username "standard_user" and password "secret
    Element Should Be Enabled    ${InputName}
    Input Text    ${InputName}   ${Username1}

The user click On the login Button
    Element Should Be Enabled   ${InputPassword}
    Input Text    ${InputPassword}   ${PositivePassword}
    
The user enters main page
    Element Should Be Enabled   ${BtnLogin}
    Click Button    ${BtnLogin}