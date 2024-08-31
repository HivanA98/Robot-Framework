*** Settings ***
Resource   step.robot
Library    SeleniumLibrary
Test Setup    Before All


*** Test Cases **
Visit website
    Open Browser    ${URL}   Chrome

Pendaftar Pertama
    Appointment
    Username
    Password

