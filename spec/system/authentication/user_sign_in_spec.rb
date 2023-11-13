require 'rails_helper'

describe 'Usuário faz login' do
  it 'a partir da tela inicial' do
    #Arrange

    #Act
    visit root_path
    within('nav') do
      click_on 'Entrar na Conta'
    end

    #Assert
    within('main form') do
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_button 'Entrar'
    end
  end

  it 'com sucesso sendo do tipo hóspede e é redirecionado para o homepage' do
    #Arrange
    maria = User.create!(name: 'Maria Barbosa', email: 'maria@gmail.com', password: 'password', role: 'guest')

    #Act
    visit root_path
    within('nav') do
      click_on 'Entrar na Conta'
    end
    within('main form') do
      fill_in 'E-mail', with: maria.email
      fill_in 'Senha', with: maria.password
      click_on 'Entrar'
    end

    #Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(current_path).to eq root_path
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Maria Barbosa'
    end
  end

  it 'com sucesso sendo do tipo anfitrião e tendo cadastrado sua pousada' do
    #Arrange
    julio = User.create!(name: 'Julio Almeida', email: 'julio@gmail.com', password: 'password', role: 'host')
    Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: julio)

    #Act
    visit root_path
    within('nav') do
      click_on 'Entrar na Conta'
    end
    within('main form') do
      fill_in 'E-mail', with: julio.email
      fill_in 'Senha', with: julio.password
      click_on 'Entrar'
    end

    #Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(current_path).to eq my_guesthouse_path
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Julio Almeida'
    end
  end

  it 'com sucesso sendo do tipo anfitrião e não tendo cadastrado sua pousada' do
    #Arrange
    julio = User.create!(name: 'Julio Almeida', email: 'julio@gmail.com', password: 'password', role: 'host')

    #Act
    visit root_path
    within('nav') do
      click_on 'Entrar na Conta'
    end
    within('main form') do
      fill_in 'E-mail', with: julio.email
      fill_in 'Senha', with: julio.password
      click_on 'Entrar'
    end

    #Assert
    expect(page).to have_content 'Você ainda não cadastrou sua pousada.'
    expect(current_path).to eq new_guesthouse_path
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
    within('main form') do
      fill_in 'E-mail', with: 'maria@gmail.com'
      fill_in 'Senha', with: ''
      click_on 'Entrar'
    end

    #Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'E-mail ou senha inválidos.'
  end
end