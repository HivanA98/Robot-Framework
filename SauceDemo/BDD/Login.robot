*** Settings ***
Resource    PositiveLoginStep.resource
Library    SeleniumLibrary

*** Test Cases ***
Scenario: Successful Login
  Given The user visit the website Saucedemo
  When The user enters username "standard_user" and password "secret
  And The user click On the login Button
  Then The user enters main page