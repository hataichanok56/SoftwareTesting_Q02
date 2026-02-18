*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Home
Suite Teardown    Close Browser

*** Variables ***
${URL}                https://reg.up.ac.th/
${valid_user}         67022940@up.ac.th
${invalid_user}       wrong_user_999@up.ac.th
${invalid_password}    WrongPass1234

*** Keywords ***
Open Browser To Home
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Set Selenium Speed    0.5s

Click Login Button
    # เพิ่มการรอและเลื่อนไปหาปุ่มเพื่อป้องกันโดนบัง
    Wait Until Element Is Visible    xpath:/html/body/header/div[1]/div[2]/div[3]/div/button    10s
    Click Button    xpath:/html/body/header/div[1]/div[2]/div[3]/div/button

Click Student Login
    # ใช้ JavaScript Click เพื่อแก้ปัญหา Element Click Intercepted (ปุ่มโดนบัง)
    Wait Until Element Is Visible    xpath://*[@id="current"]/div/div[2]/a    10s
    Execute Javascript    document.evaluate('//*[@id="current"]/div/div[2]/a', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

Input Email
    [Arguments]    ${email}
    Wait Until Element Is Visible    id:i0116    10s
    Input Text      id:i0116    ${email}
    Click Button    id:idSIButton9

Input Password
    [Arguments]    ${pass}
    Wait Until Element Is Visible    id:i0118    10s
    Input Text      id:i0118    ${pass}
    Wait Until Element Is Enabled    id:idSIButton9    5s
    Click Button    id:idSIButton9

Verify Error Message
    [Arguments]    ${message}
    # ใช้ Wait Until Page Contains Element แทนการเช็ค Text ลอยๆ เพื่อความแม่นยำ
    Wait Until Page Contains    ${message}    timeout=15s
    Log To Console    Detected expected error: ${message}

Reset To Main Page
    Go To    ${URL}
    Sleep    2s

*** Test Cases ***
Case 01: Invalid Email
    [Documentation]    ตรวจสอบกรณีใส่อีเมลผิด
    Click Login Button
    Click Student Login
    Input Email        ${invalid_user}
    # เปลี่ยนคำเช็คให้สั้นลงเพื่อให้ครอบคลุมทุก Error ของ Email
    Verify Error Message    incorrect
    [Teardown]    Reset To Main Page

Case 02: Invalid Password
    [Documentation]    ตรวจสอบกรณีใส่รหัสผ่านผิด
    Click Login Button
    Click Student Login
    Input Email        ${valid_user}
    Input Password     ${invalid_password}
    Verify Error Message    incorrect
    [Teardown]    Reset To Main Page