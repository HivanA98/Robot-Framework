*** Settings ***
Documentation    Component Object: BeautyHaul's shared Alpine.js form validation.
...              Invalid fields reveal a red ``<p>`` by swapping ``opacity-0`` for ``opacity-100``.

Resource         ../../resources/common.resource


*** Variables ***
${VISIBLE_FIELD_ERROR}    xpath://form[@id="{form}"]//*[contains(@class,"opacity-100") and normalize-space()="{message}"]


*** Keywords ***
Field Error Should Be Shown
    [Arguments]    ${form_id}    ${message}
    ${locator}    Replace String    ${VISIBLE_FIELD_ERROR}    {form}    ${form_id}
    ${locator}    Replace String    ${locator}    {message}    ${message}
    Wait Until Element Is Visible    ${locator}

Field Errors Should Be Shown
    [Arguments]    ${form_id}    @{messages}
    FOR    ${message}    IN    @{messages}
        Field Error Should Be Shown    ${form_id}    ${message}
    END

Field Error Should Not Be Shown
    [Arguments]    ${form_id}    ${message}
    ${locator}    Replace String    ${VISIBLE_FIELD_ERROR}    {form}    ${form_id}
    ${locator}    Replace String    ${locator}    {message}    ${message}
    Page Should Not Contain Element    ${locator}
