*** Settings ***
Library               SeleniumLibrary
Library               Dialogs
 
*** Variables ***
${SERVER}             reg.up.ac.th
${BROWSER}            chrome
${DELAY}              0
${VALID USER}         67022940@up.ac.th
${VALID PASSWORD}     06062547Bam?
${WELCOME URL}        https://${SERVER}/
${LOGIN URL}          https://go.up.ac.th/rY7zwj
${ERROR URL}          https://go.up.ac.th/rY7zwj
 
*** Keywords ***
Open Browser To Login Page
    Open Browser      ${WELCOME URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Click Button    xpath:/html/body/header/div[1]/div[2]/div[3]/div/button
    Sleep    3s
 
Submit Credentials
    # กดปุ่มเพื่อไปหน้า Sign-in ของ Microsoft
    Wait Until Element Is Visible    xpath://*[@id="current"]/div/div[2]/a    timeout=10s
    Click Element    xpath://*[@id="current"]/div/div[2]/a
 
Go To Login Page
    Go To    ${LOGIN URL}
    Wait Until Element Is Visible    id:i0116    timeout=10s
 
 
Input Username
    [Arguments]    ${username}
    Wait Until Element Is Visible    id:i0116    timeout=10s
    Wait Until Element Is Enabled    id:i0116    timeout=5s
    Input Text     id:i0116    ${username}
    Click Button   id:idSIButton9
 
Input Password
    [Arguments]    ${password}
    # สำคัญมาก: หน้า Microsoft ใช้เวลา Transition สั้นๆ
    Wait Until Element Is Visible    id:i0118    timeout=10s
    Wait Until Element Is Enabled    id:i0118    timeout=5s
    Input Text     id:i0118   ${password}
 
Submit Email
    # กดปุ่ม Sign in ขั้นสุดท้าย
    Click Button    xpath://*[@id="idSIButton9"]
    # เนื่องจากระบบ มพ. มี MFA ต้องใช้ Pause เพื่อกดในมือถือให้เสร็จ
    Pause Execution    กรุณายืนยันตัวตนในมือถือ (MFA) ให้เรียบร้อยแล้วกด OK
 
Login Should Have Failed
    # ตรวจสอบ Error Message กรณีใส่รหัสผิด
    Wait Until Page Contains Element    xpath://div[@id='usernameError' or @id='passwordError' or @id='loginError']    timeout=5s
    Log To Console    Detected login error as expected.
 
Welcome Page Should Be Open
    # รอให้กลับมาที่หน้าเว็บของมหาลัย
    Wait Until Location Contains    ${SERVER}    timeout=15s
    Sleep    1s
 
Sign in to your account
 
*** Settings ***
Resource          resource.robot
 
*** Test Cases ***
Valid Login Scenario
    Open Browser To Login Page
    Submit Credentials
    Input Username          ${VALID USER}
    Input Password          ${VALID PASSWORD}
    Submit Email                                 
    Welcome Page Should Be Open
    [Teardown]    Close Browser
 
 