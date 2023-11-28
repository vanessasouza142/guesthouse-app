require 'rails_helper'

describe 'Usuário anfitrião realiza check-in' do
  it 'ao acessar uma reserva' do
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
    b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 1.week.from_now, guests_number: '1')

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Reservas'
    click_on "#{b.code}"

    #Assert
    expect(current_path).to eq booking_path(b.id)
    expect(page).to have_content "Reserva #{b.code}"
    expect(page).to have_content 'Quarto: Quarto Padrão'
    expect(page).to have_content "Data de entrada: #{I18n.l(Date.today, format: "%d/%m/%Y")}"
    expect(page).to have_content "Data de saída: #{I18n.l(1.week.from_now, format: "%d/%m/%Y")}"
    expect(page).to have_content 'Quantidade de hóspedes: 1'
    expect(page).to have_content 'Status: Pendente'
    expect(page).to have_button 'Realizar Check-in'
  end

  it 'com sucesso' do
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
    b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 1.week.from_now, guests_number: '1')

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Reservas'
    click_on "#{b.code}"
    click_on 'Realizar Check-in'

    #Assert
    expect(current_path).to eq booking_path(b.id)
    expect(page).to have_content 'Check-in realizado com sucesso.'
    expect(page).to have_content "Estadia Ativa #{b.code}"
    expect(page).to have_content 'Quarto: Quarto Padrão'
    expect(page).to have_content 'Quantidade de hóspedes: 1'
    expect(page).to have_content 'Status: Em andamento'
    expect(page).to have_content "Check-in realizado em: #{I18n.l(Time.current, format: '%d/%m/%Y, às %H:%M horas')}"
    expect(page).not_to have_button 'Realizar Check-in'
  end

  it 'sem sucesso, pois o dia atual é anterior ao dia do check-in' do
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
    b = Booking.create!(room: r, user: mario, check_in_date: 1.day.from_now, check_out_date: 5.days.from_now, guests_number: '1')

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Reservas'
    click_on "#{b.code}"
    click_on 'Realizar Check-in'

    #Assert
    expect(current_path).to eq booking_path(b.id)
    expect(page).to have_content 'Ainda não é possível realizar o check-in dessa reserva.'
  end
end

