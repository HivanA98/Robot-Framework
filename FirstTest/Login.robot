*** Settings ***
Resource    LoginStep.robot
Library    SeleniumLibrary
Test Setup    Before All
Test Teardown    End All
Suite Teardown    End Testing


*** Test Cases ***
Positive Login standard
    Login Standard


Positive Login locked
    Login Locked

Negative Login
    Negative Login


