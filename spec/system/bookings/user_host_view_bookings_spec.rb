require 'rails_helper'

describe 'Usuário anfitrião vê as reservas agendadas' do
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
    visit bookings_guesthouse_path(g.id)

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'no menu Reservas' do
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
    b1 = Booking.create!(room: r, user: mario, check_in_date: '01/02/2024', check_out_date: '10/02/2024', guests_number: '1')
    b2 = Booking.create!(room: r, user: juliana, check_in_date: '20/02/2024', check_out_date: '27/02/2024', guests_number: '2')

    #Act
    login_as(luiza)
    visit root_path
    click_on 'Reservas'

    #Assert
    expect(current_path).to eq bookings_guesthouse_path(g.id)
    expect(page).to have_content 'Reservas'
    within('thead') do
      expect(page).to have_content 'Código da Reserva'
      expect(page).to have_content 'Quarto Reservado'
      expect(page).to have_content 'Data de entrada'
      expect(page).to have_content 'Data de saída'
      expect(page).to have_content 'Número de hóspedes'
    end
    within('tbody') do
      expect(page).to have_content "#{b1.code}"
      expect(page).to have_content 'Quarto Padrão'
      expect(page).to have_content '01/02/2024'
      expect(page).to have_content '10/02/2024'
      expect(page).to have_content '1'
      expect(page).to have_content "#{b2.code}"
      expect(page).to have_content 'Quarto Padrão'
      expect(page).to have_content '20/02/2024'
      expect(page).to have_content '27/02/2024'
      expect(page).to have_content '2'
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