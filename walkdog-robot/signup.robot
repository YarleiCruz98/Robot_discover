*** Settings ***
Documentation       Suite de testes de cadastro de dog walker

Library             Browser

*** Test Cases ***
Deve poder cadastrar um novo dog walker
    ${name}    Set Variable    Yarlei Cruz
    ${email}    Set Variable    yarlei@teste.com
    ${cpf}    Set Variable    00000014141
    ${cep}    Set Variable    04534011
    ${numero}    Set Variable    1000
    ${complemento}    Set Variable    quarto andar
    ${endereço_rua}    Set Variable    Rua Joaquim Floriano
    ${bairro}    Set Variable    Itaim Bibi
    ${cidade_uf}    Set Variable    São Paulo/SP
    ${menssagem_validacao}    Set Variable    Recebemos o seu cadastro e em breve retornaremos o contato.
    ${toretto_cnh}    Set Variable    toretto.jpg
        
    Go to signup page
    Fill singup form    ${name}    ${email}    ${cep}    ${cpf}    ${endereço_rua}    ${bairro}    ${bairro}    ${cidade_uf}    ${numero}    ${complemento}    ${toretto_cnh}
    Submit signup form
    Popup should be    ${menssagem_validacao}

*** Keywords ***

Go to signup page
    New Browser    browser=chromium    headless=False
    New Page    https://walkdog.vercel.app/signup
   
    Wait For Elements State    form h1    visible    timeout=5000
    Get Text    form h1    equal    Faça seu cadastro

Fill singup form
    [Arguments]    ${name}    ${email}    ${cep}    ${cpf}    ${endereço_rua}    ${bairro}    ${bairro}    ${cidade_uf}    ${numero}    ${complemento}    ${toretto_cnh}
    Fill Text    css=input[placeholder="Nome completo"]    ${name}
    Fill Text    css=input[placeholder="E-mail"]    ${email}
    Fill Text    css=input[placeholder="CPF somente números"]    ${cpf}

    Fill Text    css=input[placeholder="CEP"]    ${cep}
    Click    css=input[value="Buscar CEP"]

    Get Property    css=input[name="addressStreet"]    value    equal    ${endereço_rua}
    Get Property    css=input[name="addressDistrict"]    value    equal    ${bairro}
    Get Property    css=input[name="addressCityUf"]    value    equal    ${cidade_uf}

    Fill Text    css=input[placeholder="Número"]    ${numero}
    Get Property    css=input[name="addressNumber"]    value    equal    ${numero}

    Fill Text    css=input[placeholder="Complemento"]    ${complemento}
    Get Property    css=input[name="addressDetails"]    value    equal    ${complemento}
    
    Upload File By Selector    css=input[type="file"]   ${EXECDIR}/${toretto_cnh}
    
Submit signup form
    Click    css=.button-register

Popup should be
    [Arguments]    ${expected_text} 
    Wait For Elements State    css=.swal2-html-container    visible    timeout=5000
    Get Text    css=.swal2-html-container    equal    ${expected_text}
    Sleep    10