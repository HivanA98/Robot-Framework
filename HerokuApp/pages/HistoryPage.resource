*** Settings ***
Documentation    Page Object: appointment history (``/history.php``).

Resource         ../../resources/common.resource
Variables        ../data/cura_data.py


*** Variables ***
${HISTORY_SECTION}          id:history
${HISTORY_ENTRIES}          css:#history .panel
${HISTORY_ENTRY_BY_DATE}    xpath://section[@id="history"]//div[contains(@class,"panel")][.//div[contains(@class,"panel-heading") and normalize-space()="{date}"]]


*** Keywords ***
History Page Should Be Open
    Wait Until Location Contains    history.php
    Wait Until Element Is Visible    ${HISTORY_SECTION}

History Should Be Empty
    Page Should Not Contain Element    ${HISTORY_ENTRIES}
    Element Should Contain    ${HISTORY_SECTION}    ${NO_APPOINTMENT_MESSAGE}

History Should Contain Appointment
    [Arguments]    ${facility}    ${program}    ${date}    ${comment}=${EMPTY}
    ${entry}    Replace String    ${HISTORY_ENTRY_BY_DATE}    {date}    ${date}
    Wait Until Element Is Visible    ${entry}
    Element Should Contain    ${entry}    ${facility}
    Element Should Contain    ${entry}    ${program}
    IF    $comment    Element Should Contain    ${entry}    ${comment}
