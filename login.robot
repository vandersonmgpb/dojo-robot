*** Settings ***
Documentation        Pegar token

Library        RequestsLibrary
Library        String
Library        Collections

*** Variables ***
${baseUrl}        https://the-mentalists.qacoders-academy.com.br/api/
# ${baseUrl}        https://develop.qacoders-academy.com.br/api/

*** Test Cases ***
Validar Login
    Realizar Login

*** Keywords ***
Criar sessao
    ${headers}        Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=develop    url=${baseUrl}    headers=${headers}    verify=true

Realizar Login
    ${body}        Create Dictionary    
    ...    mail=sysadmin@qacoders.com    
    ...    password=1234@Test 
    Log    ${body}
    Criar sessao
    ${resposta}    POST On Session    alias=develop    url=/login    json=${body}
    # Log To Console    ${resposta.json()}
    # Log To Console    ${resposta.json()["token"]}
    Status Should Be    200    ${resposta}
    
        
# robot -d ./logs ./login.robot