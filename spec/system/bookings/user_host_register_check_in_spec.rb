require 'rails_helper'

describe 'Usuário anfitrião realiza check-in' do
  it 'ao acessar uma reserva' do
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
    juliana = User.create!(name: 'Juliana Matos', email: 'juliana@gmail.com', password: 'password', role: 'guest')
    b = Booking.create!(room: r, user: mario, check_in_date: '01/02/2024', check_out_date: '10/02/2024', guests_number: '1')

    #Act
    login_as(luiza)
    visit root_path
    click_on 'Reservas'
    click_on "#{b.code}"

    #Assert
    expect(current_path).to eq booking_path(b.id)
    expect(page).to have_content "Reserva #{b.code}"
    expect(page).to have_content 'Quarto Reservado: Quarto Padrão'
    expect(page).to have_content 'Data de entrada: 01/02/2024'
    expect(page).to have_content 'Data de saída: 10/02/2024'
    expect(page).to have_content 'Número de hóspedes: 1'
    expect(page).to have_content 'Status da Reserva: Pendente'
    expect(page).to have_button 'Realizar Check-in'
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
    juliana = User.create!(name: 'Juliana Matos', email: 'juliana@gmail.com', password: 'password', role: 'guest')
    b = Booking.create!(room: r, user: mario, check_in_date: '01/02/2024', check_out_date: '10/02/2024', guests_number: '1')

    #Act
    login_as(luiza)
    visit root_path
    click_on 'Reservas'
    click_on "#{b.code}"
    click_on 'Realizar Check-in'

    #Assert
    expect(current_path).to eq booking_path(b.id)
    expect(page).to have_content 'Check-in realizado com sucesso.'
    expect(page).to have_content "Reserva #{b.code}"
    expect(page).to have_content 'Quarto Reservado: Quarto Padrão'
    expect(page).to have_content 'Data de entrada: 01/02/2024'
    expect(page).to have_content 'Data de saída: 10/02/2024'
    expect(page).to have_content 'Número de hóspedes: 1'
    expect(page).to have_content 'Status da Reserva: Em andamento'
    expect(page).to have_content "Check-in realizado em: #{Date.today.strftime('%d/%m/%Y')}, às #{Time.current.strftime('%H:%M')} horas"
    expect(page).not_to have_button 'Realizar Check-in'
  end
end