*** Settings ***
Documentation     voila.id sign-in page - UI state and client-side identifier
...               validation only, nothing is submitted.

Resource          ../pages/LoginPage.resource

Suite Setup       Open Application    ${LOGIN_URL}
Suite Teardown    Close Application
Test Setup        Open Voila Login Page

Test Tags         login


*** Test Cases ***
Sign In Page Is Rendered
    [Tags]    smoke
    Sign In Form Should Be Complete
    Sign In Button Should Be Disabled

Valid Identifier Enables Sign In
    [Tags]    positive
    [Template]    Sign In Button Should Be Enabled For
    FOR    ${identifier}    IN    @{VALID_IDENTIFIERS}
        ${identifier}
    END

Invalid Identifier Keeps Sign In Disabled
    [Tags]    negative
    [Template]    Sign In Button Should Stay Disabled For
    FOR    ${identifier}    IN    @{INVALID_IDENTIFIERS}
        ${identifier}
    END

Register Link Opens Registration
    Go To Register


*** Keywords ***
Sign In Button Should Be Enabled For
    [Arguments]    ${identifier}
    Open Voila Login Page
    Enter Identifier    ${identifier}
    Sign In Button Should Be Enabled
    Clear Identifier
    Sign In Button Should Be Disabled

Sign In Button Should Stay Disabled For
    [Arguments]    ${identifier}
    Open Voila Login Page
    Enter Identifier    ${identifier}
    Sleep    1s    reason=the form validates on a short debounce
    Sign In Button Should Be Disabled
