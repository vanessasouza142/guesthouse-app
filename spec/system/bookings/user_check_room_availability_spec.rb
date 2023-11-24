require 'rails_helper'

describe 'Visitante consulta disponibilidade de um quarto durante um período' do
  it 'a partir da tela de detalhes do quarto' do
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

    #Assert
    expect(current_path).to eq new_room_booking_path(r.id)
    expect(page).to have_content 'Quarto Padrão'
    expect(page).to have_content 'Descrição: Quarto bem ventilado'
    expect(page).to have_content 'Área (m²): 10'
    expect(page).to have_content 'Quantidade max. de hóspedes: 2'
    expect(page).to have_content 'Valor da diária: R$ 180,00'
    expect(page).to have_content 'Possui banheiro'
    expect(page).to have_content 'Possui varanda'
    expect(page).to have_content 'Possui ar-condicionado'
    expect(page).to have_content 'Possui tv'
    expect(page).to have_content 'Possui guarda-roupas'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
    expect(page).to have_content 'Consulte a Disponibilidade do Quarto Padrão:'
    expect(page).to have_field 'Data de entrada'
    expect(page).to have_field 'Data de saída'
    expect(page).to have_field 'Quantidade de hóspedes'
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

    #Act
    visit root_path
    click_on 'Pousada Ouro Branco'
    click_on 'Quarto Padrão'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: '10/12/2023'
    fill_in 'Data de saída', with: '15/12/2023'
    fill_in 'Quantidade de hóspedes', with: '2'
    click_on 'Consultar'
    
    #Assert
    expect(current_path).to eq check_availability_room_bookings_path(r.id)
    expect(page).to have_content 'Quarto Padrão disponível entre os dias 10/12/2023 - 15/12/2023'
    expect(page).to have_content 'Valor total das diárias: R$ 900,00'
    expect(page).to have_content 'Para prosseguir com a reserva, você precisa criar sua conta ou fazer login:'
    expect(page).to have_link 'Prosseguir com a Reserva'
  end

  it 'com sucesso e tendo o quarto um preço personalizado no período' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                            phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                            neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                            description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                            user: luiza)
    r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '100,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)
    cp = CustomPrice.create!(begin_date: '10/12/2023', end_date: '12/12/2023', price: '200,00', room: r)

    #Act
    visit root_path
    click_on 'Pousada Ouro Branco'
    click_on 'Quarto Padrão'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: '10/12/2023'
    fill_in 'Data de saída', with: '15/12/2023'
    fill_in 'Quantidade de hóspedes', with: '2'
    click_on 'Consultar'
    
    #Assert
    expect(current_path).to eq check_availability_room_bookings_path(r.id)
    expect(page).to have_content 'Quarto Padrão disponível entre os dias 10/12/2023 - 15/12/2023'
    expect(page).to have_content 'Valor total das diárias: R$ 700,00'
    expect(page).to have_content 'Para prosseguir com a reserva, você precisa criar sua conta ou fazer login:'
    expect(page).to have_link 'Prosseguir com a Reserva'
  end

  it 'com dados incompletos' do
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
    fill_in 'Data de entrada', with: ''
    fill_in 'Data de saída', with: ''
    fill_in 'Quantidade de hóspedes', with: ''
    click_on 'Consultar'

    #Assert
    expect(current_path).to eq check_availability_room_bookings_path(r.id)
    expect(page).to have_content 'Data de entrada não pode ficar em branco'
    expect(page).to have_content 'Data de saída não pode ficar em branco'
    expect(page).to have_content 'Quantidade de hóspedes não pode ficar em branco'
  end

  it 'e não há disponibilidade' do
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

    guest = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
    booking1 = Booking.create!(check_in_date: '10/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r, user: guest)

    #Act
    visit root_path
    click_on 'Pousada Ouro Branco'
    click_on 'Quarto Padrão'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: '12/12/2023'
    fill_in 'Data de saída', with: '15/12/2023'
    fill_in 'Quantidade de hóspedes', with: '2'
    click_on 'Consultar'

    #Assert
    expect(current_path).to eq check_availability_room_bookings_path(r.id)
    expect(page).to have_content 'O quarto não está disponível para o período selecionado.'
  end
end