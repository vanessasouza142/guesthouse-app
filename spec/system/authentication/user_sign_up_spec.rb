require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'a partir da tela inicial' do
    #Arrange

    #Act
    visit root_path
    click_on 'Entrar na Conta'
    click_on 'Criar Conta'

    #Assert
    within('form') do
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Perfil de Cadastro'
      expect(page).to have_button 'Criar'
    end
  end

  it 'com sucesso' do
    #Arrange

    #Act
    visit root_path
    click_on 'Entrar na Conta'
    click_on 'Criar Conta'
    fill_in 'Nome', with: 'Maria Barbosa'
    fill_in 'E-mail', with: 'maria@example.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    select 'guest', from: 'Perfil de Cadastro'
    click_on 'Criar'

    #Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Maria Barbosa'
    expect(page).to have_content 'Sair'
  end
end