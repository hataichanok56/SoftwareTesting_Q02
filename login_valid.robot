*** Settings ***
Library           SeleniumLibrary
Library           Dialogs
Suite Setup       Open Browser    https://reg.up.ac.th/    chrome
Suite Teardown    Close Browser

*** Variables ***
${username}       67022940@up.ac.th
${password}       06062547Bam?


*** Keywords ***
Click Login Button
    Wait Until Element Is Visible    xpath:/html/body/header/div[1]/div[2]/div[3]/div/button    10s
    Click Button    xpath:/html/body/header/div[1]/div[2]/div[3]/div/button

Click Student Login
    Wait Until Element Is Visible    xpath://*[@id="current"]/div/div[2]/a    10s
    Click Element    xpath://*[@id="current"]/div/div[2]/a

Input Email Account
    Wait Until Element Is Visible    id:i0116    10s
    Input Text      id:i0116    ${username}
    Click Button    id:idSIButton9

Input Password Account
    Wait Until Element Is Visible    id:i0118    10s
    Input Text      id:i0118    ${password}
    Wait Until Element Is Enabled    id:idSIButton9    5s
    Click Button    id:idSIButton9

Select SMS Authentication
    Wait Until Element Is Visible    id:signInAnotherWay    10s
    Click Element    id:signInAnotherWay
    Wait Until Element Is Visible    xpath://div[contains(text(), 'Text')]    10s
    Click Element    xpath://div[contains(text(), 'Text')]

Wait For SMS Verification
    Pause Execution    กรุณากรอกรหัสจาก SMS ในหน้าเว็บให้เรียบร้อย แล้วจึงกด OK


*** Test Cases ***
Login Test SMS 
    Click Login Button
    Click Student Login
    Input Email Account
    Input Password Account
    Select SMS Authentication
    Wait For SMS Verification


    
        