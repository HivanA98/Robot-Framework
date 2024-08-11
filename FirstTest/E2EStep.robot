*** Settings ***
Library    SeleniumLibrary
Variables    Resource.py

*** Keywords ***
Setup Test Case
    Open Browser    ${URL}   Chrome
    Input Text    ${InputName}   standard_user
    Input Text    ${InputPassword}   secret_sauce
    Click Element    ${BtnLogin}

AdditemSingle
    Click Element    ${PrtBackpack}

AddDoubleItem
    Click Element    ${PrtBackpack}
    Click Element    ${PrtBikeLight}

AddTripleItem
    Click Element    ${PrtBackpack}
    Click Element    ${PrtBikeLight}
    Click Element    ${PrtBoltTShirt}


AdditemMultiple
    Click Element    ${PrtBackpack}
    Click Element    ${PrtBikeLight}
    Click Element    ${PrtBoltTShirt}
    Click Element    ${PrtFleeceJacket}
    Click Element    ${PrtOnesie}

Chekcout
    Click Element    ${BtnCart}
    Click Element    ${BtnCheckout}

InputAddreas
    Input Text    ${InputFirstName}   ${NameFirst}
    Input Text    ${InputLastName}    ${NameLast}
    Input Text    ${PostalCode}     ${Postal}
    Click Element    ${BtnContinue}

FinishTransacton
    Click Element    ${BtnFinish}

