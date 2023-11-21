require 'rails_helper'

describe 'Usuário anfitrião cancela reserva' do
  it 'com sucesso, depois de 2 dias do dia previsto para o check-in' do
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
    b = Booking.create!(room: r, user: mario, check_in_date: 4.days.ago, check_out_date: 1.week.from_now, guests_number: '1')

    #Act
    login_as(luiza)
    visit root_path
    click_on 'Reservas'
    click_on "#{b.code}"
    click_on 'Cancelar Reserva'

    #Assert
    expect(current_path).to eq bookings_guesthouse_path(g.id)
    expect(page).to have_content 'Reserva cancelada com sucesso.'
    expect(Booking.count).to eq 0
  end

  it 'sem sucesso, depois de 1 dia do dia previsto para o check-in' do
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
    b = Booking.create!(room: r, user: mario, check_in_date: 1.day.ago, check_out_date: 1.week.from_now, guests_number: '1')

    #Act
    login_as(luiza)
    visit root_path
    click_on 'Reservas'
    click_on "#{b.code}"
    click_on 'Cancelar Reserva'

    #Assert
    expect(current_path).to eq booking_path(b.id)
    expect(page).to have_content 'Só é possível cancelar a reserva após 2 dias da data prevista para o check-in.'
    expect(Booking.count).to eq 1
  end
end