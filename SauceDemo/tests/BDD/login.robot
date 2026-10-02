*** Comments ***
# Gherkin steps are written as natural sentences, not Title Case.
# robocop: off=wrong-case-in-keyword-call


*** Settings ***
Documentation     Feature: Login
...               As a SauceDemo customer I want to sign in
...               so that I can browse and buy products.

Resource          steps.resource

Suite Setup       Start SauceDemo Suite
Suite Teardown    Close Application

Test Tags         bdd    login


*** Test Cases ***
Scenario: Successful login
    [Tags]    positive    smoke
    Given the user is on the SauceDemo login page
    When the user logs in with username "standard_user" and password "secret_sauce"
    Then the products page is displayed

Scenario: Wrong password
    [Tags]    negative
    Given the user is on the SauceDemo login page
    When the user logs in with username "standard_user" and password "NotASecret"
    Then the error "Epic sadface: Username and password do not match any user in this service" is displayed

Scenario: Locked out user
    [Tags]    negative
    Given the user is on the SauceDemo login page
    When the user logs in with username "locked_out_user" and password "secret_sauce"
    Then the error "Epic sadface: Sorry, this user has been locked out." is displayed
