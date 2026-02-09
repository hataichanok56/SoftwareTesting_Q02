*** Settings ***
Library             SeleniumLibrary  timeout=10s   implicit_wait=5s
Suite Setup         Open Browser     https://reg.up.ac.th/app/main  chrome       
Suite Teardown      Close Browser    

*** Variables ***
${username}       67022940@up.ac.th
${password}       06062547Bam?


*** Keywords ***
click Login
    Click Element    /html/body/header/div[1]/div[2]/div[3]/div/button

click Student Login
    Click Element    //*[@id="current-mobile"]/div/div[2]/a

Input email
    Input Text    //*[@id="i0116"]    ${username}   
    Click Element    //*[@id="idSIButton9"] 
Input password
    Input Text    //*[@id="i0118"]    ${password}   
    Click Element    //*[@id="idSIButton9"]

click menu
    Click Element    //*[@id="box-topmenu"]/ul/li[4]/a
    Click Element   //*[@id="box-topmenu"]/ul/li[4]/ul

Click grade
    Click Element   //*[@id="1"]/td[6]/select 
    Click Element   //*[@id="2"]/td[6]/select   
    Click Element   //*[@id="3"]/td[6]/select
    Click Element   //*[@id="4"]/td[6]/select
    Click Element   //*[@id="btnSave"]
    



*** Test Cases ***
Test RF02
    click Login
    click Student Login
    Input email
    Input password

