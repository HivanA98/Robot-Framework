*** Settings ***
Documentation    Page Object: BeautyHaul registration (``/account/register``).
...
...              *Safety guard*: ``Submit Register Form`` clears the birth date and
...              asserts the terms box is unchecked, so the client-side validator always
...              aborts before any request is sent.

Resource         ../../resources/common.resource
Resource         FormValidation.resource
Variables        ../data/beautyhaul_data.py


*** Variables ***
${REGISTER_FORM_ID}        registerForm
${REG_FIRST_NAME}          css:#registerForm input[name="nama_depan"]
${REG_LAST_NAME}           css:#registerForm input[name="nama_belakang"]
${REG_EMAIL}               css:#registerForm input[name="email"]
${REG_PHONE}               css:#registerForm input[name="nomor_ponsel"]
${REG_PASSWORD}            css:#registerForm input[name="password"]
${REG_CONFIRM_PASSWORD}    css:#registerForm input[name="konfirmasi_password"]
${REG_BIRTH_DATE}          css:#registerForm input[name="tanggal_lahir"]
${REG_TERMS}               css:#registerForm input[name="terms"]
${REG_GENDER}              xpath://form[@id="registerForm"]//button[normalize-space()="{gender}"]
${REG_SUBMIT}              css:#registerForm button:not([type="button"])

&{REGISTER_FIELDS}
...                        first_name=${REG_FIRST_NAME}
...                        last_name=${REG_LAST_NAME}
...                        email=${REG_EMAIL}
...                        phone=${REG_PHONE}
...                        password=${REG_PASSWORD}
...                        confirm_password=${REG_CONFIRM_PASSWORD}


*** Keywords ***
Open Register Page
    Go To    ${REGISTER_URL}
    Wait Until Element Is Visible    ${REG_SUBMIT}

Fill Register Field
    [Documentation]    ``field`` is a key of ``&{REGISTER_FIELDS}``.
    [Arguments]    ${field}    ${value}
    VAR    ${locator}    ${REGISTER_FIELDS}[${field}]
    IF    'password' in $field
        Secret When Ready    ${locator}    ${value}
    ELSE
        Type When Ready    ${locator}    ${value}
    END

Fill Register Form
    [Documentation]    Fills any subset of fields, e.g. ``first_name=Ivan  email=a@b.co``.
    [Arguments]    &{fields}
    FOR    ${field}    ${value}    IN    &{fields}
        Fill Register Field    ${field}    ${value}
    END

Fill Valid Register Data
    [Documentation]    Valid values (FakerLibrary) for every typed field. Birth date stays empty.
    ${first}    FakerLibrary.First Name
    ${last}    FakerLibrary.Last Name
    ${email}    FakerLibrary.Email
    ${password}    FakerLibrary.Password    length=10    special_chars=False
    Fill Register Form
    ...    first_name=${first[:20]}
    ...    last_name=${last[:20]}
    ...    email=${email}
    ...    phone=81234567890
    ...    password=${password}
    ...    confirm_password=${password}

Choose Gender
    [Arguments]    ${gender}
    ${locator}    Replace String    ${REG_GENDER}    {gender}    ${gender}
    Click When Ready    ${locator}

Submit Register Form
    [Documentation]    Safety guard: two independent client-side blockers are enforced
    ...    before clicking, so the form can never reach the server:
    ...    the (pre-filled) birth date is cleared and the terms box must be unchecked.
    Execute Javascript    document.querySelector('#registerForm input[name="tanggal_lahir"]').value = '';
    Element Attribute Value Should Be    ${REG_BIRTH_DATE}    value    ${EMPTY}
    ...    Safety guard: birth date must be empty
    Element Attribute Value Should Be    ${REG_TERMS}    value    false
    ...    Safety guard: terms must stay unchecked
    Click When Ready    ${REG_SUBMIT}

Register Error Should Be Shown
    [Arguments]    @{messages}
    Field Errors Should Be Shown    ${REGISTER_FORM_ID}    @{messages}

Register Error Should Not Be Shown
    [Arguments]    ${message}
    Field Error Should Not Be Shown    ${REGISTER_FORM_ID}    ${message}

Registration Should Be Blocked
    Location Should Be    ${REGISTER_URL}
    Register Error Should Be Shown    ${MSG}[birth_date_required]

Register Field Value Should Be
    [Arguments]    ${field}    ${expected}
    VAR    ${locator}    ${REGISTER_FIELDS}[${field}]
    ${value}    Get Value    ${locator}
    Should Be Equal    ${value}    ${expected}
