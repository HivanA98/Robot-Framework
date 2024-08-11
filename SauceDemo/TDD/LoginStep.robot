*** Settings ***
Library    SeleniumLibrary
Variables    ..//Resource.py


*** Keywords ***

Before All
    Open Browser    ${URL}   Chrome

End All
    Delete All Cookies

End Testing
    Close Browser

Login Standard
    Element Should Be Enabled    ${InputName}
    Input Text    ${InputName}   ${Username1}
    Element Should Be Enabled   ${InputPassword}
    Input Text    ${InputPassword}   ${PositivePassword}
    Element Should Be Enabled   ${BtnLogin}
    Click Button    ${BtnLogin}
Login Locked
    Element Should Be Enabled    ${InputName}
    Input Text    ${InputName}   ${Username2}
    Element Should Be Enabled    ${InputPassword}
    Input Text    ${InputPassword}   ${PositivePassword}
    Element Should Be Enabled    ${BtnLogin}
    Click Button    ${BtnLogin}

Login Problem
    Element Should Be Enabled    ${InputName}
    Input Text    ${InputName}   ${Username3}
    Element Should Be Enabled    ${InputPassword}
    Input Text    ${InputPassword}   ${PositivePassword}
    Element Should Be Enabled    ${BtnLogin}
    Click Button    ${BtnLogin}

Login Glitch
    Element Should Be Enabled    ${InputName}
    Input Text    ${InputName}   ${Username4}
    Element Should Be Enabled    ${InputPassword}
    Input Text    ${InputPassword}   ${PositivePassword}
    Element Should Be Enabled    ${BtnLogin}
    Click Button    ${BtnLogin}

Negative Login
    Element Should Be Enabled    ${InputName}
    Input Text    ${InputName}   ${NegativeUsername}
    Element Should Be Enabled    ${InputPassword}
    Input Text    ${InputPassword}   ${NegativePassword}
    Element Should Be Enabled    ${BtnLogin}
    Click Button    ${BtnLogin}
    Element Should Be Visible   ${ErrorWarning}    
