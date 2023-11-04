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

  it 'com sucesso sendo do tipo hóspede' do
    #Arrange
    maria = User.create!(name: 'Maria Barbosa', email: 'maria@gmail.com', password: 'password', role: 'guest')

    #Act
    visit root_path
    login(maria)

    #Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(current_path).to eq root_path
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Maria Barbosa'
    end
  end

  it 'com sucesso sendo do tipo anfitrião' do
    #Arrange
    julio = User.create!(name: 'Julio Almeida', email: 'julio@gmail.com', password: 'password', role: 'host')
    Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
    phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
    neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
    description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
    usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: julio)

    #Act
    visit root_path
    login(julio)

    #Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(current_path).to eq my_guesthouse_path
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Julio Almeida'
    end
  end

  it 'sem sucesso' do
    #Arrange
    maria = User.create!(name: 'Maria Barbosa', email: 'maria@gmail.com', password: 'password', role: 'guest')

    #Act
    visit root_path
    within('nav') do
      click_on 'Entrar na Conta'
    end
    fill_in 'E-mail', with: 'maria@gmail.com'
    fill_in 'Senha', with: ''
    click_on 'Entrar'

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'E-mail ou senha inválidos.'
  end
end