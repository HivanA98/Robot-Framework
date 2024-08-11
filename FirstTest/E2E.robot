*** Settings ***
Resource   E2EStep.robot
Library    SeleniumLibrary
Test Setup    Setup Test Case


*** Test Cases ***
E2E Single order
    AdditemSingle
    Chekcout
    InputAddreas
    FinishTransacton

E2E Double orders
    AddDoubleItem
    Chekcout
    InputAddreas
    FinishTransacton

E2E Triple orders
    AddTripleItem
    Chekcout
    InputAddreas
    FinishTransacton

E2E Multiple orders
    AdditemMultiple
    Chekcout
    InputAddreas
    FinishTransacton
