*** Settings ***
Documentation     BeautyHaul registration - client-side validation rules.
...               Every submit goes through a safety guard (see RegisterPage), so nothing is ever sent.

Resource          ../pages/BeautyHaul.resource

Suite Setup       Start BeautyHaul Suite
Suite Teardown    Close Application
Test Setup        Fresh Register Page

Test Tags         register


*** Test Cases ***
Empty Form Lists Every Required Field
    [Tags]    negative    smoke
    Submit Register Form
    Wait Until Page Contains    ${REQUIRED_TOAST}
    Register Error Should Be Shown
    ...    ${MSG}[first_name_required]    ${MSG}[last_name_required]    ${MSG}[email_required]
    ...    ${MSG}[phone_required]    ${MSG}[password_required]    ${MSG}[confirm_required]
    ...    ${MSG}[birth_date_required]

Field Rules Are Enforced
    [Tags]    negative
    [Template]    Register Field Should Be Rejected
    # field    value    expected message
    first_name    I    ${MSG}[first_name_min]
    first_name    ABCDEFGHIJKLMNOPQRSTU    ${MSG}[first_name_max]
    last_name    A    ${MSG}[last_name_min]
    last_name    ABCDEFGHIJKLMNOPQRSTU    ${MSG}[last_name_max]
    email    ivan@mail    ${MSG}[email_format]
    phone    812345    ${MSG}[phone_min]
    password    a1    ${MSG}[password_min]
    password    abcdefgh    ${MSG}[password_rule]
    password    12345678    ${MSG}[password_rule]

Password Confirmation Must Match
    [Tags]    negative
    Fill Register Form    password=Rahasia123    confirm_password=Rahasia321
    Submit Register Form
    Register Error Should Be Shown    ${MSG}[confirm_mismatch]

Valid Data Only Misses Birth Date
    [Documentation]    With every typed field valid, the only blocker left is the birth date.
    Fill Valid Register Data
    Choose Gender    Perempuan
    Submit Register Form
    Registration Should Be Blocked
    FOR    ${key}    IN    first_name_required    email_format    password_rule    confirm_mismatch    phone_min
        Register Error Should Not Be Shown    ${MSG}[${key}]
    END

Phone Number Cannot Start With Zero
    [Documentation]    The site strips a leading 0 because +62 is already selected.
    Fill Register Form    phone=081234567
    Register Field Value Should Be    phone    81234567


*** Keywords ***
Register Field Should Be Rejected
    [Arguments]    ${field}    ${value}    ${expected_message}
    Fresh Register Page
    Fill Register Field    ${field}    ${value}
    Submit Register Form
    Register Error Should Be Shown    ${expected_message}
    Registration Should Be Blocked
