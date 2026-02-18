*** Settings ***
Library           SeleniumLibrary
Library           Dialogs
Suite Setup       Open Browser    https://reg.up.ac.th/    chrome
Suite Teardown    Close Browser

*** Variables ***
${username}           67022940@up.ac.th
${password}           06062547Bam?
${LOGIN_URL}          https://reg.up.ac.th/
${SERVER}             reg.up.ac.th
${BTN_ENTER_REG}      xpath:/html/body/header/div[1]/div[2]/div[3]/div/button
${BTN_STAY_SIGNED_IN}  id:idSIButton9

*** Keywords ***
Click Login Button
    Wait Until Element Is Visible    ${BTN_ENTER_REG}    10s
    Click Button    ${BTN_ENTER_REG}

Click Student Login
    Wait Until Element Is Visible    xpath://*[@id="current"]/div/div[2]/a    10s
    Execute Javascript    document.evaluate('//*[@id="current"]/div/div[2]/a', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

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
    
    ${stay_in}    Run Keyword And Return Status    Wait Until Element Is Visible    ${BTN_STAY_SIGNED_IN}    10s
    IF    ${stay_in}
        Click Element    ${BTN_STAY_SIGNED_IN}
    END

    Wait Until Location Contains    ${SERVER}    timeout=30s
    # รอให้ Session สร้างเสร็จสักครู่
    Sleep    3s

Check Login Status And Enter Main Page
    # บังคับไปหน้า Main เพื่อให้เมนู Topmenu ปรากฏ
    Go To    https://${SERVER}/app/main
    # รอจนกว่าเมนูหลักจะโหลดเสร็จ
    Wait Until Element Is Visible    id:box-topmenu    20s
    Set Screenshot Directory    ${CURDIR}/results/screenshots
    Capture Page Screenshot    logged_in_success.png

test retry
    # คลิกเมนู ตรวจสอบผลการเรียน (เมนูที่ 4)
    Wait Until Element Is Visible    xpath://*[@id="box-topmenu"]/ul/li[4]/a/b    15s
    Click Element    xpath://*[@id="box-topmenu"]/ul/li[4]/a/b
    # คลิกเมนูย่อย ตรวจสอบผลการเรียนตามโครงสร้าง (เมนูย่อยที่ 3)
    Wait Until Element Is Visible    xpath://*[@id="box-topmenu"]/ul/li[4]/ul/li[3]/a/b    10s
    Click Element    xpath://*[@id="box-topmenu"]/ul/li[4]/ul/li[3]/a/b
    Log To Console    Successfully navigated to Grade Report Page.

*** Test Cases ***
Login Test SMS 
    Click Login Button
    Click Student Login
    Input Email Account
    Input Password Account
    Select SMS Authentication
    Wait For SMS Verification
    Check Login Status And Enter Main Page
    test retry