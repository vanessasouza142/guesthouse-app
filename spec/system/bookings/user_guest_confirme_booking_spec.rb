require 'rails_helper'

describe 'Usuário hóspede confirma a reserva' do
  it 'e deve estar autenticado' do
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
    visit confirm_booking_path

    #Arrange
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')

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
    click_on 'Confirmar Reserva'

    #Assert
    expect(current_path).to eq my_bookings_path
    expect(page).to have_content 'Reserva realizada com sucesso.'
    expect(page).to have_content 'Minhas Reservas'
    expect(page).to have_content 'Quarto Padrão'
    expect(page).to have_content '10/12/2023'
    expect(page).to have_content '15/12/2023'
    expect(page).to have_content '2'
    expect(page).to have_content 'ABC12345'
    expect(Booking.count).to eq 1
  end

  # it 'sem sucesso' do
  #   #Arrange
  #   luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', password: 'password', role: 'host')
  #   g = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
  #                           phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
  #                           neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
  #                           description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
  #                           usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
  #                           user: luiza)
  #   r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
  #                     bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
  #                     status: 'available', guesthouse: g)

  #   #Act
  #   visit root_path
  #   click_on 'Pousada Ouro Branco'
  #   click_on 'Quarto Padrão'
  #   click_on 'Reservar'
  #   fill_in 'Data de entrada', with: '10/12/2023'
  #   fill_in 'Data de saída', with: '15/12/2023'
  #   fill_in 'Quantidade de hóspedes', with: '2'
  #   click_on 'Consultar'
  #   click_on 'Prosseguir com a Reserva'
  #   guest_sign_up
  #   page.driver.browser.clear_cookies
  #   click_on 'Confirmar Reserva'

  #   #Assert
  #   expect(current_path).to eq room_path(r.id)
  #   expect(page).to have_content 'Reserva não realizada.'
  #   expect(Booking.count).to eq 0
  # end
end