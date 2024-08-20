*** Settings ***
Resource   step.robot
Library    SeleniumLibrary

*** Test Cases **
Visit website
    Open Browser    ${URL}   Chrome