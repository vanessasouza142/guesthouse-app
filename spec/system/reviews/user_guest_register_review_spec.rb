require 'rails_helper'

describe 'Usuário hóspede registra uma avaliação' do
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

    guest = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')

    #Act
    visit new_booking_review_path(booking.id)

    #Assert
    expect(current_path).to eq new_user_session_path

  end

  it 'a partir da tela Minhas Reservas' do
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

    guest = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')

    #Act
    login_as(guest)
    visit root_path
    click_on 'Minhas Reservas'
    click_on booking.code
    click_on 'Registrar Avaliação'

    #Assert
    expect(current_path).to eq new_booking_review_path(booking.id)
    expect(page).to have_content "Registrar Avaliação da Hospedagem #{booking.code}"
    expect(page).to have_field 'Nota'
    expect(page).to have_field 'Avaliação'
    expect(page).to have_button 'Salvar'
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

    guest = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    #Act
    login_as(guest)
    visit root_path
    click_on 'Minhas Reservas'
    click_on booking.code
    click_on 'Registrar Avaliação'
    fill_in 'Nota', with: '4.5'
    fill_in 'Avaliação', with: 'Minha estadia foi muito boa.'
    click_on 'Salvar'

    #Assert
    expect(current_path).to eq booking_path(booking.id)
    expect(page).to have_content 'Avaliação registrada com sucesso.'   
    expect(page).to have_content 'Avaliação da Hospedagem'
    expect(page).to have_content 'Nota: 4,5'
    expect(page).to have_content 'Avaliação: Minha estadia foi muito boa.'
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

    guest = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    #Act
    login_as(guest)
    visit root_path
    click_on 'Minhas Reservas'
    click_on booking.code
    click_on 'Registrar Avaliação'
    fill_in 'Nota', with: ''
    fill_in 'Avaliação', with: ''
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Avaliação não registrada.'   
    expect(page).to have_content 'Nota não pode ficar em branco'
    expect(page).to have_content 'Avaliação não pode ficar em branco'
  end
end