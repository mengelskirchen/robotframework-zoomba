*** Settings ***
Documentation    Zoomba Mobile Library Tests. Requires Appium Server running on port 4723 with an Android device/emulator available.
Library          Zoomba.MobileLibrary
Suite Setup      Start App
Suite Teardown   Close Application
Force Tags       Mobile

*** Variables ***
${REMOTE_URL}           http://ondemand.us-west-1.saucelabs.com/wd/hub
${commandTimeout}=      120

*** Keywords ***
Start App
    Open Application        ${REMOTE_URL}     platformName=iOS        deviceName=iPhone XS Simulator
    ...                     newCommandTimeout=${commandTimeout}       browserName=Safari    username=${sauce_username}
    ...                     access_key=${sauce_key}    platformVersion=14.5       name=GitHub.${SUITE_NAME}
    ...                     build=${GITHUB_RUN_NUMBER}

*** Test Cases ***
Scroll To Text In WebView Keyword Test
    Go To Url    https://www.win-rar.com/products-winrar.html
    Scroll Down    //h3[contains(text(),'FEATURES')]
    Scroll Up    //h3[contains(text(),'OVERVIEW')]
    Scroll Down To Text    SYSTEM REQUIREMENTS
    Scroll Up To Text      RAR Products

Wait For And Click Element By Id Keyword Test
    Background App    -1
    Switch To Context    NATIVE_APP
    Wait For And Click Element       Contacts
    Wait Until Page Contains      Contacts

Wait For And Click Element By Xpath Keyword Test
    Background App    -1
    Wait For And Click Element       //XCUIElementTypeIcon[@name="Contacts"]
    Wait Until Page Contains      Contacts

Wait For And Input Text/Password Keyword Test
    Wait For And Input Text    Search    John
    Wait Until Page Contains       John Appleseed
    Wait For And Click Element    //XCUIElementTypeButton[@name="Cancel"]
    Wait For And Input Password    Search    John
    Wait Until Page Contains       John Appleseed
    Wait For And Click Element    //XCUIElementTypeButton[@name="Cancel"]

Wait For And Long Press Keyword Test
    Wait For And Long Press       //XCUIElementTypeCell[@name="John Appleseed"]/XCUIElementTypeOther[1]/XCUIElementTypeOther
    Wait Until Page Contains Element    message
    Click A Point    10    100

Wait Until Element is Enabled Keyword Test
    Wait Until Element Is Enabled       Add

Wait Until Element Contains / Does Not Contain
    Wait For And Input Text    Search    John
    Wait Until Element Contains    Search     John
    Wait For And Click Element    //XCUIElementTypeButton[@name="Cancel"]
    Wait Until Element Does Not Contain    Search     John

Drag and Drop Keyword Test
    Background App    -1
    Wait For And Long Press     Files
    Wait For And Click Element       OK
    Drag and Drop                Files      Watch
    Page Should Contain Element    Folder
    Drag and Drop By Offset                Shortcuts          180      0
    Page Should Contain Element        //XCUIElementTypeIcon[@name="Folder"]/XCUIElementTypeIcon[@name="Shortcuts"]
    Run keyword And Expect Error         ValueError: Element locator 'Not_a_real_id' did not match any elements.
    ...            Drag and Drop         Not_a_real_id      Watch
    Wait For And Click Element    Done

Scroll To Text In NativeApp Keyword Test
    Background App    -1
    Swipe By Percent    10    50    90    50
    Wait For And Click Element       Settings
    Wait Until Page Contains      Settings
    Scroll Down To Text    Developer
    Element Should Be Visible    Developer
    Scroll Up To Text     General
    Element Should Be Visible    General
    Scroll Down To Text    Developer
    Element Should Be Visible    Developer
    Scroll Up    General
    Element Should Be Visible    General

Save Selenium Screenshot Test
    ${file1}=                       Save Appium Screenshot
    ${file2}=                       Save Appium Screenshot
    Should Not Be Equal             ${file1}  ${file2}
    Should Match Regexp             ${file1}                    appium-screenshot-\\d{8,10}.\\d{6,8}-\\d.png
