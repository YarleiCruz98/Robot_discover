*** Settings ***
Documentation        Ações, steps e elementos da funcionalidade de cadastro

Library             Browser

*** Keywords ***

Go to signup page
    Click    css=a[href="/signup"]
   
    Wait For Elements State    form h1    visible    timeout=5000
    Get Text    form h1    equal    Faça seu cadastro

Fill singup form
    [Arguments]    ${dog_walker}    
    
    Fill Text    css=input[name=name]    ${dog_walker}[name]
    Fill Text    css=input[placeholder="E-mail"]    ${dog_walker}[email]
    Fill Text    css=input[placeholder="CPF somente números"]    ${dog_walker}[cpf]

    Fill Text    css=input[placeholder="CEP"]    ${dog_walker}[cep]
    Click    css=input[value="Buscar CEP"]

    Get Property    css=input[name="addressStreet"]    value    equal    ${dog_walker}[endereço_rua]
    Get Property    css=input[name="addressDistrict"]    value    equal    ${dog_walker}[bairro]
    Get Property    css=input[name="addressCityUf"]    value    equal    ${dog_walker}[cidade_uf]

    Fill Text    css=input[placeholder="Número"]    ${dog_walker}[numero]
    Get Property    css=input[name="addressNumber"]    value    equal    ${dog_walker}[numero]

    Fill Text    css=input[placeholder="Complemento"]    ${dog_walker}[complemento]
    Get Property    css=input[name="addressDetails"]    value    equal    ${dog_walker}[complemento]
    
    Upload File By Selector    css=input[type="file"]   ${EXECDIR}/resources/fixtures/${dog_walker}[toretto_cnh]
    
Submit signup form
    Click    css=.button-register    

Popup should be
    [Arguments]    ${expected_text} 
    Wait For Elements State    css=.swal2-html-container    visible    timeout=5000
    Get Text    css=.swal2-html-container    equal    ${expected_text}

Alert should be
    [Arguments]    ${expected_text} 
    Wait For Elements State   css=.alert-error >> text=${expected_text}
    ...    visible        5

Select additional service
    [Arguments]    ${expected_text} 
    Click    xpath=//span[text()="${expected_text}"]/..
