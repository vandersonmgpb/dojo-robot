*** Settings ***
Documentation        Pegar token

Library        RequestsLibrary
Library        String
Library        Collections

*** Variables ***
${baseUrl}        https://the-mentalists.qacoders-academy.com.br/api/
${id_user}        65f5cb40bfc21aa670ec2a69

*** Test Cases ***
Listar usuários
    Listagem users

Contar Usuário
    Count Users
Pegar Usuário
    Get User

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

Listagem Users
    ${token}    Pegar Token       
    GET On Session    alias=develop    url=/user/?token=${token} 

Count Users
    ${token}    Pegar Token       
    GET On Session    alias=develop    url=/user/count?token=${token} 
Get User
    ${token}    Pegar Token       
    GET On Session    alias=develop    url=/user/${id_user}?token=${token} 
       
    
        
# robot -d ./logs ./login.robot