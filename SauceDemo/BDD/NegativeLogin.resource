*** Settings ***
Library    SeleniumLibrary
Variables    ..//Resource.py

*** Keywords ***
Validation First Name Negative
    ${elements}=    Get WebElements    ${InputName}
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Element Attribute    ${element}    value
        ${length}=    Get Length    ${text}
        Should Be True    ${length} >= 1    ${text} length should be at least 1
        Should Be True    ${length} <= 2    ${text} length should be at most 2
        Should Match Regexp    ${text}    ^(?=.*[0-9])(?=.*[A-Za-z])[A-Za-z0-9]*$
    END

The user visit main website Saucedemo
    Open Browser    ${URL}   Chrome

The user enters username "standard_user" and wrong password "NotAsecret"
    Element Should Be Enabled    ${InputName}
    Input Text    ${InputName}   ${Username1}
    Element Should Be Enabled   ${InputPassword}
    Input Text    ${InputPassword}   ${NegativePassword}

The user click the login Button
    Element Should Be Enabled   ${BtnLogin}
    Click Button    ${BtnLogin}    
    
The user sees an error message
    Element Should Be Visible    ${ErrorWarning}