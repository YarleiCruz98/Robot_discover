*** Settings ***
Documentation       Suite de testes de cadastro de dog walker

Resource        ../resources/base.resource     

Test Setup    Start session
Test Teardown    Finish session

*** Test Cases ***
Deve poder cadastrar um novo dog walker
        
    ${dog_walker}        Create Dictionary
    ...    name=Yarlei Cruz
    ...    email=yarlei@teste.com
    ...    cpf=00000014141
    ...    cep=04534011
    ...    numero=1000
    ...    complemento=quarto andar
    ...    endereço_rua=Rua Joaquim Floriano
    ...    bairro=Itaim Bibi
    ...    cidade_uf=São Paulo/SP
    ...    menssagem_validacao=Recebemos o seu cadastro e em breve retornaremos o contato.
    ...    toretto_cnh=toretto.jpg
    
    Go to signup page
    Fill singup form    ${dog_walker}
    Submit signup form
    Popup should be    ${dog_walker}[menssagem_validacao]

Não deve poder cadastrar um novo dog walker se o cpf estiver incorreto
    [Tags]    cpf_inv    
    ${dog_walker}        Create Dictionary
    ...    name=Yarlei Cruz
    ...    email=yarlei@teste.com
    ...    cpf=000000141aa
    ...    cep=04534011
    ...    numero=1000
    ...    complemento=quarto andar
    ...    endereço_rua=Rua Joaquim Floriano
    ...    bairro=Itaim Bibi
    ...    cidade_uf=São Paulo/SP
    ...    menssagem_validacao=Recebemos o seu cadastro e em breve retornaremos o contato.
    ...    toretto_cnh=toretto.jpg
    ...    msg_cpf_invalido=CPF inválido

    Go to signup page
    Fill singup form    ${dog_walker}
    Submit signup form
    Alert should be    ${dog_walker}[msg_cpf_invalido]

Não deve cadastras se os campos obrigatórios não forem preenchidos

    [Tags]    required_field     
    ${dog_walker}        Create Dictionary

    Go to signup page
    Submit signup form
    Alert should be    Informe o seu nome completo
    Alert should be    Informe o seu melhor email
    Alert should be    Informe o seu CPF
    Alert should be    Informe o seu CEP
    Alert should be    Informe um número maior que zero

Deve poder cadastrar um novo dog walker que saiba cuidar de pets

    [Tags]    required_field    
    ${dog_walker}        Create Dictionary
    ...    name=Yarlei Cruz
    ...    email=yarlei@teste.com
    ...    cpf=00000014141
    ...    cep=04534011
    ...    numero=1000
    ...    complemento=quarto andar
    ...    endereço_rua=Rua Joaquim Floriano
    ...    bairro=Itaim Bibi
    ...    cidade_uf=São Paulo/SP
    ...    menssagem_validacao=Recebemos o seu cadastro e em breve retornaremos o contato.
    ...    toretto_cnh=toretto.jpg
    
    Go to signup page
    Fill singup form    ${dog_walker}
    Select additional service    Cuidar
    Submit signup form
    Popup should be    ${dog_walker}[menssagem_validacao]

Deve poder cadastrar um novo dog walker que saiba adestrar pets

    [Tags]    required_field    
    ${dog_walker}        Create Dictionary
    ...    name=Yarlei Cruz
    ...    email=yarlei@teste.com
    ...    cpf=00000014141
    ...    cep=04534011
    ...    numero=1000
    ...    complemento=quarto andar
    ...    endereço_rua=Rua Joaquim Floriano
    ...    bairro=Itaim Bibi
    ...    cidade_uf=São Paulo/SP
    ...    menssagem_validacao=Recebemos o seu cadastro e em breve retornaremos o contato.
    ...    toretto_cnh=toretto.jpg
    
    Go to signup page
    Fill singup form    ${dog_walker}
    Select additional service    Adestrar
    Submit signup form
    Popup should be    ${dog_walker}[menssagem_validacao]    