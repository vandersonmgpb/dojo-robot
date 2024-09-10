*** Settings ***
Documentation            Teste Projeeto

*** Variables ***
${nome}        Fulano de Tall

*** Test Cases ***
Imprimir Nome no Terminal
    Imprimir Nome

*** Keywords ***
Imprimir Nome
    Log To Console    Olá ${nome}, Seja bem vindo ao Dojo de Robot