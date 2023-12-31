require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Usuário anfitrião realiza check-out' do
  it 'ao acessar uma estadia ativa' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', cpf: '38573169346', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                            phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                            neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                            description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                            user: luiza)
    r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', cpf: '70661435660', password: 'password', role: 'guest')
    b = Booking.create!(room: r, user: mario, check_in_date: 5.days.ago, check_out_date: Date.today, guests_number: '1',
                        status: 'in_progress', check_in_done: 5.days.ago.change(hour: 14, minute: 0))

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Estadias Ativas'
    click_on "#{b.code}"

    #Assert
    expect(current_path).to eq booking_path(b.id)
    expect(page).to have_content "Estadia Ativa #{b.code}"
    expect(page).to have_content 'Quarto: Quarto Padrão'
    expect(page).to have_content "Quantidade de hóspedes: #{b.guests_number}"
    expect(page).to have_content 'Status: Em andamento'
    expect(page).to have_content "Check-in realizado em: #{I18n.l(b.check_in_done, format: '%d/%m/%Y, às %H:%M horas')}"
    expect(page).to have_button 'Realizar Check-out'
  end

  it 'com sucesso dentro do horário de check-out da pousada' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', cpf: '38573169346', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                            phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                            neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                            description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                            user: luiza)
    r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', cpf: '70661435660', password: 'password', role: 'guest')
    b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 1.week.from_now, guests_number: '1',
                        status: 'in_progress', check_in_done: '14/11/2023')

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Estadias Ativas'
    click_on "#{b.code}"
    travel_to Time.zone.local(2023, 11, 19, 11, 45)
    click_on 'Realizar Check-out'

    #Assert
    expect(current_path).to eq payment_booking_path(b.id)
    expect(page).to have_content 'Check-out realizado com sucesso dentro do horário previsto.'
    expect(page).to have_content "Pagamento da Hospedagem #{b.code}"
    expect(page).to have_content 'Check-out realizado em: 19/11/2023, às 11:45 horas'
    expect(page).to have_content 'Período da hospedagem: 14/11/2023 a 19/11/2023'
    expect(page).to have_content 'Valor total a pagar: R$ 900,00'
    expect(page).to have_field 'Valor do Pagamento'
    expect(page).to have_field 'Método de Pagamento'
    travel_back
  end

  it 'com sucesso e passou do horário de check-out da pousada' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', cpf: '38573169346', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                            phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                            neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                            description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                            user: luiza)
    r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', cpf: '70661435660', password: 'password', role: 'guest')
    b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 1.week.from_now, guests_number: '1',
                        status: 'in_progress', check_in_done: '14/11/2023')

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Estadias Ativas'
    click_on "#{b.code}"
    travel_to Time.zone.local(2023, 11, 19, 13, 15)
    click_on 'Realizar Check-out'

    #Assert
    expect(current_path).to eq payment_booking_path(b.id)
    expect(page).to have_content 'Check-out realizado com sucesso mas depois do horário previsto, portanto será cobrada mais uma diária.'
    expect(page).to have_content "Pagamento da Hospedagem #{b.code}"
    expect(page).to have_content 'Check-out realizado em: 19/11/2023, às 13:15 horas'
    expect(page).to have_content 'Período da hospedagem: 14/11/2023 a 19/11/2023'
    expect(page).to have_content 'Valor total a pagar: R$ 1.080,00'
    expect(page).to have_field 'Valor do Pagamento'
    expect(page).to have_field 'Método de Pagamento'
    travel_back
  end
end
