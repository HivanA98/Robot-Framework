*** Settings ***
Documentation    Page Object: "Make Appointment" form and its confirmation page.

Resource         ../../resources/common.resource
Variables        ../data/cura_data.py


*** Variables ***
${APPT_SECTION}           id:appointment
${APPT_FACILITY}          id:combo_facility
${APPT_READMISSION}       id:chk_hospotal_readmission
${APPT_PROGRAM_RADIO}     css:input[name="programs"][value="{program}"]
${APPT_VISIT_DATE}        id:txt_visit_date
${APPT_COMMENT}           id:txt_comment
${APPT_BOOK}              id:btn-book-appointment
${CONFIRM_SECTION}        css:#summary h2
${CONFIRM_FACILITY}       id:facility
${CONFIRM_READMISSION}    id:hospital_readmission
${CONFIRM_PROGRAM}        id:program
${CONFIRM_VISIT_DATE}     id:visit_date
${CONFIRM_COMMENT}        id:comment


*** Keywords ***
Appointment Page Should Be Open
    [Documentation]    For a logged-in user the form lives on the landing page itself,
    ...    so the URL is not a reliable signal; the form is.
    Wait Until Element Is Visible    ${APPT_FACILITY}
    Wait Until Element Is Visible    ${APPT_BOOK}

Select Facility
    [Arguments]    ${facility}
    Select From List By Label    ${APPT_FACILITY}    ${facility}

Set Hospital Readmission
    [Arguments]    ${apply}
    IF    ${apply}
        Select Checkbox    ${APPT_READMISSION}
    ELSE
        Unselect Checkbox    ${APPT_READMISSION}
    END

Select Healthcare Program
    [Arguments]    ${program}
    ${radio}    Replace String    ${APPT_PROGRAM_RADIO}    {program}    ${program}
    Click When Ready    ${radio}

Set Visit Date
    [Documentation]    The field is backed by a datepicker; typing + ESC avoids the popup.
    [Arguments]    ${date}
    Type When Ready    ${APPT_VISIT_DATE}    ${date}
    Press Keys    ${APPT_VISIT_DATE}    ESC

Fill Appointment
    [Arguments]    ${facility}    ${readmission}    ${program}    ${date}    ${comment}=${EMPTY}
    Appointment Page Should Be Open
    Select Facility    ${facility}
    Set Hospital Readmission    ${readmission}
    Select Healthcare Program    ${program}
    Set Visit Date    ${date}
    IF    $comment    Type When Ready    ${APPT_COMMENT}    ${comment}

Book Appointment
    Click When Ready    ${APPT_BOOK}

Visit Date Should Be Required
    [Documentation]    The date input carries HTML5 ``required``, so the browser blocks submit.
    Element Attribute Value Should Be    ${APPT_VISIT_DATE}    required    true
    ${valid}    Execute Javascript    return document.getElementById('txt_visit_date').checkValidity();
    Should Not Be True    ${valid}
    Appointment Page Should Be Open

Confirmation Should Show
    [Arguments]    ${facility}    ${readmission}    ${program}    ${date}    ${comment}=${EMPTY}
    Wait Until Location Contains    appointment.php#summary
    Text Should Be    ${CONFIRM_SECTION}    Appointment Confirmation
    ${readmission_text}    Set Variable If    ${readmission}    Yes    No
    Element Text Should Be    ${CONFIRM_FACILITY}    ${facility}
    Element Text Should Be    ${CONFIRM_READMISSION}    ${readmission_text}
    Element Text Should Be    ${CONFIRM_PROGRAM}    ${program}
    Element Text Should Be    ${CONFIRM_VISIT_DATE}    ${date}
    Element Text Should Be    ${CONFIRM_COMMENT}    ${comment}
