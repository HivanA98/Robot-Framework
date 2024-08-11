*** Settings ***
Library    SeleniumLibrary
Variables    Resource.py

*** Keywords ***

Before All
    Open Browser    ${URL}   Chrome
    Maximize Browser Window
    Element Should Be Enabled    ${InputName}
    Input Text    ${InputName}   ${Username1}
    Element Should Be Enabled   ${InputPassword}
    Input Text    ${InputPassword}   ${PositivePassword}
    Element Should Be Enabled   ${BtnLogin}
    Click Element    ${BtnLogin}

End All
    Element Should Be Enabled    ${FinishTransaction}
    Click Element    ${FinishTransaction}
    Delete All Cookies

End Testing
    Close Browser

AdditemSingle
    Element Should Be Enabled    ${PrtBackpack}
    Click Element    ${PrtBackpack}

AddDoubleItem
    Element Should Be Enabled    ${PrtBackpack}
    Click Element    ${PrtBackpack}
    Element Should Be Enabled    ${PrtBikeLight}
    Click Element    ${PrtBikeLight}

AddTripleItem
    Element Should Be Enabled    ${PrtBackpack}
    Click Element    ${PrtBackpack}
    Element Should Be Enabled    ${PrtBikeLight}
    Click Element    ${PrtBikeLight}
    Element Should Be Enabled    ${PrtBoltTShirt}
    Click Element    ${PrtBoltTShirt}


AdditemMultiple
    Element Should Be Enabled    ${PrtBackpack}
    Click Element    ${PrtBackpack}
    Element Should Be Enabled    ${PrtBikeLight}
    Click Element    ${PrtBikeLight}
    Element Should Be Enabled    ${PrtBoltTShirt}
    Click Element    ${PrtBoltTShirt}
    Element Should Be Enabled    ${PrtFleeceJacket}
    Click Element    ${PrtFleeceJacket}
    Element Should Be Enabled    ${PrtOnesie}
    Click Element    ${PrtOnesie}

Chekcout
    Element Should Be Enabled    ${BtnCart}
    Click Element    ${BtnCart}
    Element Should Be Enabled    ${BtnCheckout}
    Click Element    ${BtnCheckout}

InputAddreas
    Element Should Be Enabled    ${InputFirstName}
    Input Text    ${InputFirstName}   ${NameFirst}
    Element Should Be Enabled    ${InputLastName}
    Input Text    ${InputLastName}    ${NameLast}
    Element Should Be Enabled    ${PostalCode}
    Input Text    ${PostalCode}     ${Postal}
    Element Should Be Enabled    ${BtnContinue}
    Click Element    ${BtnContinue}

FinishTransacton
    Element Should Be Enabled    ${BtnFinish}
    Click Element    ${BtnFinish}

