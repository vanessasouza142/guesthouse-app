require 'rails_helper'

describe 'Usuário faz login' do
  it 'a partir da tela inicial' do
    #Arrange

    #Act
    visit root_path
    click_on 'Entrar na Conta'

    #Assert
    within('form') do
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_button 'Entrar'
    end
  end

  it 'com sucesso' do
    #Arrange
    User.create!(name: 'Maria Barbosa', email: 'maria@gmail.com', password: 'password', role: 'guest')

    #Act
    visit root_path
    within('nav') do
      click_on 'Entrar na Conta'
    end
    fill_in 'E-mail', with: 'maria@gmail.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    #Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Maria Barbosa'
    end
  end
end