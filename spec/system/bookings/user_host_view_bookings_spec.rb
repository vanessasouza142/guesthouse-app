require 'rails_helper'

describe 'Usuário anfitrião vê as reservas agendadas da sua pousada' do
  it 'e deve estar autenticado' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                            phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                            neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                            description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                            user: luiza)

    #Act
    visit bookings_guesthouse_path(g.id)

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'ao acessar o menu Reservas' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                            phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                            neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                            description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                            user: luiza)
    r1 = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)
    r2 = Room.create!(name: 'Quarto Premium', description: 'Quarto maravilhoso', area: '13', max_guest: '4', default_price: '250,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'sim', accessible: 'sim',
                      status: 'available', guesthouse: g)
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', password: 'password', role: 'guest')
    juliana = User.create!(name: 'Juliana Matos', email: 'juliana@gmail.com', password: 'password', role: 'guest')
    b1 = Booking.create!(room: r1, user: mario, check_in_date: 1.week.from_now, check_out_date: 2.weeks.from_now, guests_number: '1', 
                          status: 'pending')
    b2 = Booking.create!(room: r2, user: juliana, check_in_date: 1.day.from_now, check_out_date: 5.days.from_now, guests_number: '4',
                          status: 'pending')

    #Act
    login_as(luiza)
    visit root_path
    click_on 'Reservas'

    #Assert
    expect(current_path).to eq bookings_guesthouse_path(g.id)
    expect(page).to have_content 'Reservas'
    within('thead') do
      expect(page).to have_content 'Código da Reserva'
      expect(page).to have_content 'Quarto'
      expect(page).to have_content 'Data de entrada'
      expect(page).to have_content 'Data de saída'
      expect(page).to have_content 'Quantidade de hóspedes'
    end
    within('tbody') do
      expect(page).to have_content "#{b1.code}"
      expect(page).to have_content 'Quarto Padrão'
      expect(page).to have_content "#{I18n.l(1.week.from_now, format: "%d/%m/%Y")}"
      expect(page).to have_content "#{I18n.l(2.weeks.from_now, format: "%d/%m/%Y")}"
      expect(page).to have_content "#{b2.code}"
      expect(page).to have_content 'Quarto Premium'
      expect(page).to have_content "#{I18n.l(1.day.from_now, format: "%d/%m/%Y")}"
      expect(page).to have_content "#{I18n.l(5.days.from_now, format: "%d/%m/%Y")}"
    end
  end

  it 'e não vê reservas com status:em andamento' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                            phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                            neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                            description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                            user: luiza)
    r1 = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)
    r2 = Room.create!(name: 'Quarto Premium', description: 'Quarto maravilhoso', area: '13', max_guest: '4', default_price: '250,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'sim', accessible: 'sim',
                      status: 'available', guesthouse: g)
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', password: 'password', role: 'guest')
    juliana = User.create!(name: 'Juliana Matos', email: 'juliana@gmail.com', password: 'password', role: 'guest')
    b1 = Booking.create!(room: r1, user: mario, check_in_date: 1.week.from_now, check_out_date: 2.weeks.from_now, guests_number: '1', 
                          status: 'pending')
    b2 = Booking.create!(room: r2, user: juliana, check_in_date: 1.day.from_now, check_out_date: 5.days.from_now, guests_number: '4',
                          status: 'in_progress')

    #Act
    login_as(luiza)
    visit root_path
    click_on 'Reservas'

    #Assert
    expect(current_path).to eq bookings_guesthouse_path(g.id)
    expect(page).to have_content 'Reservas'
    within('thead') do
      expect(page).to have_content 'Código da Reserva'
      expect(page).to have_content 'Quarto'
      expect(page).to have_content 'Data de entrada'
      expect(page).to have_content 'Data de saída'
      expect(page).to have_content 'Quantidade de hóspedes'
    end
    within('tbody') do
      expect(page).to have_content "#{b1.code}"
      expect(page).to have_content 'Quarto Padrão'
      expect(page).to have_content "#{I18n.l(1.week.from_now, format: "%d/%m/%Y")}"
      expect(page).to have_content "#{I18n.l(2.weeks.from_now, format: "%d/%m/%Y")}"
      expect(page).not_to have_content "#{b2.code}"
      expect(page).not_to have_content 'Quarto Premium'
      expect(page).not_to have_content "#{I18n.l(1.day.from_now, format: "%d/%m/%Y")}"
      expect(page).not_to have_content "#{I18n.l(5.days.from_now, format: "%d/%m/%Y")}"
    end
  end

  it 'e vê mensagem caso não existam reservas' do
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
    login_as(luiza)
    visit root_path
    click_on 'Reservas'

    #Assert
    expect(current_path).to eq bookings_guesthouse_path(g.id)
    expect(page).to have_content 'Reservas'
    expect(page).to have_content 'Você não tem reservas no momento.'
  end
end