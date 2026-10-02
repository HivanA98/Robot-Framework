*** Settings ***
Documentation    Page Object: CURA login form (``/profile.php#login``).

Resource         ../../resources/common.resource
Variables        ../data/cura_data.py


*** Variables ***
${CURA_USERNAME}       id:txt-username
${CURA_PASSWORD}       id:txt-password
${CURA_LOGIN}          id:btn-login
${CURA_LOGIN_ERROR}    css:#login p.text-danger


*** Keywords ***
Login Page Should Be Open
    Wait Until Location Contains    profile.php#login
    Wait Until Element Is Visible    ${CURA_LOGIN}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Login Page Should Be Open
    Type When Ready    ${CURA_USERNAME}    ${username}
    Secret When Ready    ${CURA_PASSWORD}    ${password}
    Click When Ready    ${CURA_LOGIN}

Login As Demo User
    Login With Credentials    ${DEMO_USERNAME}    ${DEMO_PASSWORD}

Login Should Have Failed
    Text Should Be    ${CURA_LOGIN_ERROR}    ${LOGIN_FAILED}
    Login Page Should Be Open
