require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Usuário anfitrião registra pagamento da hospedagem' do
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
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', password: 'password', role: 'guest')
    b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 1.week.from_now, guests_number: '1',
                        status: 'in_progress', check_in_done: '14/11/2023')
    #Act
    visit payment_booking_path(b.id)

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
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', password: 'password', role: 'guest')
    b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 1.week.from_now, guests_number: '1',
                        status: 'in_progress', check_in_done: '14/11/2023')

    #Act
    login_as(luiza)
    visit root_path
    click_on 'Estadias Ativas'
    click_on "#{b.code}"
    travel_to Time.zone.local(2023, 11, 19, 11, 45)
    click_on 'Realizar Check-out'
    fill_in 'Valor do Pagamento', with: '900,00'
    fill_in 'Método de Pagamento', with: 'Cartão'
    click_on 'Registrar Pagamento'

    #Assert
    expect(current_path).to eq my_guesthouse_path
    expect(page).to have_content 'Pagamento registrado com sucesso.'
    travel_back
  end

  it 'com dados incompletos' do
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
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', password: 'password', role: 'guest')
    b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 1.week.from_now, guests_number: '1',
                        status: 'in_progress', check_in_done: '14/11/2023')

    #Act
    login_as(luiza)
    visit root_path
    click_on 'Estadias Ativas'
    click_on "#{b.code}"
    travel_to Time.zone.local(2023, 11, 19, 11, 45)
    click_on 'Realizar Check-out'
    fill_in 'Valor do Pagamento', with: ''
    fill_in 'Método de Pagamento', with: ''
    click_on 'Registrar Pagamento'

    #Assert
    expect(current_path).to eq register_payment_booking_path(b.id)
    expect(page).to have_content 'Pagamento não registrado.'
    expect(page).to have_content 'Valor do Pagamento não pode ficar em branco'
    expect(page).to have_content 'Método de Pagamento não pode ficar em branco'
    travel_back
  end
end