*** Settings ***

Library    SeleniumLibrary
Library    RequestsLibrary
Library  Collections


Resource    D:/Py/RFCoinswitchAPI/Locators.robot


*** Keywords ***

Initialize Suite
    Set Suite Variable    ${LIMIT PRICE}    ${EMPTY}
    Set Suite Variable    ${LAST ASKS VALUE}    ${EMPTY}

Open browser and navigate to Coinswitch URL

    Open Browser    ${URL}    ${WebDriver}
    Maximize Browser Window
    Log To Console    Coinswitch homepage is displayed

#Verifying the "Trade Now" button in the home page

The User is on the homepage
    ${Homepage} =    Get Title
    Log To Console    ${Homepage}


The User clicks on the "Trade Now" button
    Click Button    ${TradeNow}

The User is redirected to the Trade Now page
    ${TradeTitle} =    Get Title
    Log To Console    ${TradeTitle}

The User handles the pop-ups
    Wait Until Element Is Visible    ${Explore}
    Click Button    ${Explore}
    Wait Until Element Is Visible    ${Skipall}
    Click Element    ${Skipall}
    Wait Until Element Is Visible    ${Done}
    Click Element    ${Done}
    Execute Javascript    window.scrollBy(0, -500);

Select Option
    [Arguments]    ${option}
    Wait Until Element Is Visible    ${option}
    Click Element    ${option}

Select Exchange
    Wait Until Element Is Visible    ${SelectExchange}
    Click Element    ${SelectExchange}
    [Arguments]    ${SelectXchange}
    Wait Until Element Is Visible    ${SelectXchange}
    Click Element    ${SelectXchange}

Get the lowest price from the Get Lowest Price field
    Wait Until Element Is Visible    ${GetLowest}
    Click Element    ${GetLowest}
    #Getting the Limit Price value
    ${Price} =    Get Value    ${LimPrice}
    Log To Console    LimitPrice:${Price}
    Set Suite Variable    ${LIMIT PRICE}    ${Price}

Get lowest price from API
    #Getting data from API
    Wait Until Element Is Visible    ${GetLowest}
    Create Session    Coinswitch    https://coinswitch.co/pro
    ${header}=    Create Dictionary    Content-Type=application/json

Get Response
    [Arguments]    ${symbol}    ${exchange}
    ${query_params}=    Create Dictionary    symbol=${symbol}    exchange=${exchange}
    ${response}=    GET On Session   Coinswitch    /api/v1/realtime-rates/depth    params=${query_params}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    ${response.content}
    #Getting the Last aks value
    ${json_string}=    Set Variable    ${response.text}
    ${response_dict}=    Evaluate    json.loads('''${json_string}''')    json
    ${asks_list}=    Set Variable    ${response_dict['data']['asks']}
    ${last_asks_value}=    Set Variable    ${asks_list[0][0]}
    Log To Console    Last asks Value: ${last_asks_value}
    Set Suite Variable    ${LAST ASKS VALUE}    ${last_asks_value}
        
Assertion
    Log To Console    LimitPrice:${LIMIT PRICE}
    Log To Console    LastAsks:${LAST ASKS VALUE}
    #Run Keyword If    '${LIMIT PRICE}' == '${LAST ASKS VALUE}'    Log to console    LowestPrice assertion passed:${LIMIT PRICE}==${LAST ASKS VALUE}
    Should Be Equal As Numbers    ${LIMIT PRICE}    ${LAST ASKS VALUE}
    Log To Console    LowestPrice assertion passed:${LIMIT PRICE}==${LAST ASKS VALUE}
    Sleep    1s




    


    


    



    