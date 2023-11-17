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
      expect(page).to have_field 'CPF'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Perfil de Cadastro'
      expect(page).to have_button 'Criar'
    end
  end

  it 'com sucesso sendo do tipo hóspede' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                            phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                            neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                            description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                            user: luiza)
    r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)

    #Act
    visit root_path
    click_on 'Pousada Ouro Branco'
    click_on 'Quarto Padrão'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: '10/12/2023'
    fill_in 'Data de saída', with: '15/12/2023'
    fill_in 'Quantidade de hóspedes', with: '2'
    click_on 'Consultar'
    click_on 'Prosseguir com a Reserva'
    guest_sign_up

    #Assert
    expect(current_path).to eq confirm_booking_path
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
    fill_in 'CPF', with: '18598745698'
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