*** Settings ***
Resource    PositiveLoginStep.robot
Resource    NegativeLogin.robot
Library    SeleniumLibrary

*** Test Cases ***
Scenario: Successful Login
  Given The user visit the website Saucedemo
  When The user enters username "standard_user" and password "secret"
  And The user click On the login Button
  Then The user enters main page

Scenario: Unsuccessful Login
  Given The user visit main website Saucedemo
  When The user enters username "standard_user" and wrong password "NotAsecret"
  And The user click the login Button
  Then The user sees an error message