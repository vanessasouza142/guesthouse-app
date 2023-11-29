require 'rails_helper'

describe 'Usuário hóspede cancela reserva' do
  it 'e não está autenticado' do
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
    b = Booking.create!(room: r, user: mario, check_in_date: 1.week.from_now, check_out_date: 2.weeks.from_now, guests_number: '1')
    
    #Act
    delete(guest_cancel_booking_path(b.id))

    #Assert
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'e não é o dono' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', cpf: '38573169346', password: 'password', role: 'host')
    g1 = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                            phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                            neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                            description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                            user: luiza)
    r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g1)
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', cpf: '70661435660', password: 'password', role: 'guest')
    b1 = Booking.create!(room: r, user: mario, check_in_date: 1.week.from_now, check_out_date: 2.weeks.from_now, guests_number: '1')

    carla = User.create!(name: 'Carla Oliveira', email: 'carla@gmail.com', cpf: '48682787547', password: 'password', role: 'guest')
    b2 = Booking.create!(room: r, user: carla, check_in_date: 3.weeks.from_now, check_out_date: 4.weeks.from_now, guests_number: '2')

    
    #Act
    login_as(carla)
    delete(guest_cancel_booking_path(b1.id))

    #Assert
    expect(response).to redirect_to(root_path)
  end
end