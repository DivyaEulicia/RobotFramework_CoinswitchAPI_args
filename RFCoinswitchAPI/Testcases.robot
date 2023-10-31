*** Settings ***

Resource    D:/Py/RFCoinswitchAPI/Keywords.robot

Suite Setup     Initialize Suite
Suite Teardown    Close Browser

*** Test Cases ***

Open browser and navigate to Coinswitch URL   
    Open browser and navigate to Coinswitch URL   


Verify the "Trade Now" button in the home page
    Given The User is on the homepage
    When The User clicks on the "Trade Now" button
    Then The User is redirected to the Trade Now page
    And The User handles the pop-ups

Get price from Get Lowest Price field and get Lowest Price from API
    Select Option    ${GAS}               # ${BTC} | ${SOL} | ${GAS}
    Select Exchange    ${CoinSwitchX}     # ${CoinSwitchX} | ${WazirX}
    Get the lowest price from the Get Lowest Price field    
    FOR    ${i}    IN RANGE    5
        Get lowest price from API
        Get Response    ${Sym3}    ${Ex1}      # btc,inr | sol,inr | gas,inr |     csx | wz
        Assertion
    END

