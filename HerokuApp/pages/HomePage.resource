*** Settings ***
Documentation    Page Object: CURA landing page + side menu (available on every page).

Resource         ../../resources/common.resource
Variables        ../data/cura_data.py


*** Variables ***
${HOME_MAKE_APPOINTMENT}    id:btn-make-appointment
${MENU_TOGGLE}              id:menu-toggle
${MENU_SIDEBAR}             id:sidebar-wrapper
${MENU_LINK}                xpath://nav[@id="sidebar-wrapper"]//a[normalize-space()="{label}"]


*** Keywords ***
Open Home Page
    Go To    ${BASE_URL}/
    Wait Until Element Is Visible    ${HOME_MAKE_APPOINTMENT}

Click Make Appointment
    Click When Ready    ${HOME_MAKE_APPOINTMENT}

Navigate Via Menu
    [Documentation]    ``label`` is the visible link text: Home, History, Profile, Login or Logout.
    [Arguments]    ${label}
    Click When Ready    ${MENU_TOGGLE}
    ${link}    Replace String    ${MENU_LINK}    {label}    ${label}
    Click When Ready    ${link}

Menu Should Offer
    [Arguments]    @{labels}
    Click When Ready    ${MENU_TOGGLE}
    FOR    ${label}    IN    @{labels}
        ${link}    Replace String    ${MENU_LINK}    {label}    ${label}
        Wait Until Element Is Visible    ${link}
    END
    Click When Ready    ${MENU_TOGGLE}
