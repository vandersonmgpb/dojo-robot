*** Settings ***
Documentation        Pegar token

Library        RequestsLibrary
Library        String
Library        Collections

*** Variables ***
${baseUrl}        https://the-mentalists.qacoders-academy.com.br/api/
${id_user}        65f5cb40bfc21aa670ec2a69

*** Test Cases ***
Mudar status de usuario para false
    Put Status False
Mudar status de usuario para true
    Put Status True
*** Keywords ***
Criar Sessao
    ${headers}        Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=develop    url=${baseUrl}    headers=${headers}    verify=true

Pegar Token 
    ${body}        Create Dictionary    
    ...    mail=sysadmin@qacoders.com    
    ...    password=1234@Test 
    # Log    ${body}
    Criar sessao
    ${resposta}    POST On Session    alias=develop    url=/login    json=${body}
    # Log To Console    ${resposta.json()}
    # Log To Console    ${resposta.json()["token"]}
    Status Should Be    200    ${resposta}
    RETURN              ${resposta.json()["token"]}    

Put Status False
    ${token}    Pegar Token
    ${body}    Create Dictionary    status=false
    PUT On Session    alias=develop    url=/user/status/${id_user}?token=${token}    json=${body}
Put Status True
    ${token}    Pegar Token
    ${body}    Create Dictionary    status=true
    PUT On Session    alias=develop    url=/user/status/${id_user}?token=${token}    json=${body}
    


       
    
        
# robot -d ./logs ./login.robot