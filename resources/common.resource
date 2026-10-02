*** Settings ***
Documentation    Shared foundation for every Page Object:
...              browser lifecycle, state reset and "wait-then-act" wrappers.
...              Page objects import this file; test suites import page objects only.

Library          Collections
Library          DateTime
Library          String
Variables        ${CURDIR}/config.py
Library          SeleniumLibrary    timeout=${TIMEOUT}    run_on_failure=Capture Page Screenshot
Library          FakerLibrary    locale=id_ID
Library          ${CURDIR}/libraries/TestHelpers.py


*** Keywords ***
# ---------------------------------------------------------------- lifecycle
Open Application
    [Documentation]    Open ``url`` in ``${BROWSER}`` (headless aware) with a fixed window size.
    [Arguments]    ${url}
    ${options}    Build Browser Options    ${BROWSER}    ${HEADLESS}    ${WINDOW_WIDTH}    ${WINDOW_HEIGHT}
    Open Browser    ${url}    ${BROWSER}    options=${options}
    Set Window Size    ${WINDOW_WIDTH}    ${WINDOW_HEIGHT}

Close Application
    Close All Browsers

Reset Browser State
    [Documentation]    Cheap alternative to reopening the browser between tests:
    ...    wipe cookies + web storage, then land on ``url`` again.
    [Arguments]    ${url}
    Go To    ${url}
    Delete All Cookies
    Execute Javascript    window.localStorage.clear(); window.sessionStorage.clear();
    Go To    ${url}

# ---------------------------------------------------------------- wait-then-act

Click When Ready
    [Documentation]    Retries briefly so a click that lands while the page is still
    ...    smooth-scrolling (another element would receive the click) is not fatal.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Wait Until Element Is Enabled    ${locator}
    Wait Until Keyword Succeeds    5x    300ms    Scroll Into View And Click    ${locator}

Scroll Into View And Click
    [Arguments]    ${locator}
    Scroll Element Into View    ${locator}
    Click Element    ${locator}

Type When Ready
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}
    Input Text    ${locator}    ${text}

Secret When Ready
    [Documentation]    Like ``Type When Ready`` but the value is not written to the log.
    [Arguments]    ${locator}    ${secret}
    Wait Until Element Is Visible    ${locator}
    Input Password    ${locator}    ${secret}

Text Should Be
    [Arguments]    ${locator}    ${expected}
    Wait Until Element Is Visible    ${locator}
    Element Text Should Be    ${locator}    ${expected}

Get Texts
    [Documentation]    Return the visible text of every element matching ``locator``.
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}
    ${elements}    Get WebElements    ${locator}
    VAR    @{texts}    @{EMPTY}
    FOR    ${element}    IN    @{elements}
        Append To List    ${texts}    ${element.text}
    END
    RETURN    ${texts}
