*** Settings ***
Resource   LoginStep.robot
Library    SeleniumLibrary
Test Setup    Before All

*** Test Cases **
NormalLogin
    Before All
    Username1