*** Settings ***
Library    SeleniumLibrary
Variables    Resource.py

*** Keywords ***

Before All
    Open Browser    ${URL}/account/register   Chrome
    Maximize Browser Window
    
Username1
    Element Should Be Visible    ${UsernameLogin}
    Input Text    ${UsernameLogin}   ${NormalUser}