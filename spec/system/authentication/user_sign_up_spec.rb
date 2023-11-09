require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'a partir da tela inicial' do
    #Arrange

    #Act
    visit root_path
    click_on 'Entrar na Conta'
    click_on 'Criar Conta'

    #Assert
    within('main form') do
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Perfil de Cadastro'
      expect(page).to have_button 'Criar'
    end
  end

  it 'com sucesso sendo do tipo hóspede' do
    #Arrange

    #Act
    visit root_path
    guest_sign_up

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Maria Barbosa'
    expect(page).to have_content 'Sair'
  end

  it 'com sucesso sendo do tipo anfitrião' do
    #Arrange

    #Act
    visit root_path
    host_sign_up

    #Assert
    expect(current_path).to eq new_guesthouse_path
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Julio Almeida'
    expect(page).to have_content 'Sair'
  end

  it 'sem sucesso' do
    #Arrange

    #Act
    visit root_path
    click_on 'Entrar na Conta'
    click_on 'Criar Conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: 'julio@example.com'
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: 'password'
    select 'Anfitrião', from: 'Perfil de Cadastro'
    click_on 'Criar'

    #Assert
    expect(current_path).to eq user_registration_path
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end
end