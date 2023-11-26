require 'rails_helper'

context 'POST /api/v1/rooms/1/bookings/check_availability' do
  it 'consulta disponibilidade de um quarto' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', 
                                    registration_number:'39165040000129', phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', 
                                    address: 'Av. Beira Mar, 45', neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', 
                                    postal_code: '54350820', description: 'Pousada a beira mar maravilhosa', 
                                    payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                                    usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00',
                                    status: 'active', user: paulo)
    room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', 
                        default_price: '210,00', bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', 
                        safe: 'não', accessible: 'sim', status: 'available', guesthouse: guesthouse)
    booking_params = { booking: {check_in_date: "#{1.day.from_now}", check_out_date: "#{5.days.from_now}", guests_number: '2', room: room}}

    #Act
    post "/api/v1/rooms/#{room.id}/bookings/check_availability", params: booking_params

    #Assert
    expect(response.status).to eq 200
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response["total_price"]).to eq 840
  end

  it 'falha se parametros não estão completos' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', 
                                    registration_number:'39165040000129', phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', 
                                    address: 'Av. Beira Mar, 45', neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', 
                                    postal_code: '54350820', description: 'Pousada a beira mar maravilhosa', 
                                    payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                                    usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00',
                                    status: 'active', user: paulo)
    room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', 
                        default_price: '210,00', bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', 
                        safe: 'não', accessible: 'sim', status: 'available', guesthouse: guesthouse)
    booking_params = { booking: {check_in_date: '', check_out_date: '', guests_number: '', room: room}}

    #Act
    post "/api/v1/rooms/#{room.id}/bookings/check_availability", params: booking_params

    #Assert
    expect(response.status).to eq 412
    expect(response.content_type).to include 'application/json'
    expect(response.body).to include 'Data de entrada não pode ficar em branco'
    expect(response.body).to include 'Data de saída não pode ficar em branco'
    expect(response.body).to include 'Quantidade de hóspedes não pode ficar em branco'
  end

  it 'falha se quarto não está disponível' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', 
                                    registration_number:'39165040000129', phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', 
                                    address: 'Av. Beira Mar, 45', neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', 
                                    postal_code: '54350820', description: 'Pousada a beira mar maravilhosa', 
                                    payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                                    usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00',
                                    status: 'active', user: paulo)
    room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', 
                        default_price: '210,00', bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', 
                        safe: 'não', accessible: 'sim', status: 'available', guesthouse: guesthouse)

    guest = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
    booking = Booking.create!(check_in_date: "#{1.week.from_now}", check_out_date: "#{2.weeks.from_now}", guests_number: '2', 
                              room: room, user: guest)

    booking_params = { booking: {check_in_date: "#{1.week.from_now}", check_out_date: "#{2.weeks.from_now}", guests_number: '2', room: room}}

    #Act
    post "/api/v1/rooms/#{room.id}/bookings/check_availability", params: booking_params

    #Assert
    expect(response.status).to eq 412
    expect(response.content_type).to include 'application/json'
    expect(response.body).to include 'O quarto não está disponível para o período selecionado.'
  end

  it 'falha se tiver um erro interno' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', 
                                    registration_number:'39165040000129', phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', 
                                    address: 'Av. Beira Mar, 45', neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', 
                                    postal_code: '54350820', description: 'Pousada a beira mar maravilhosa', 
                                    payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                                    usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00',
                                    status: 'active', user: paulo)
    room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', 
                        default_price: '210,00', bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', 
                        safe: 'não', accessible: 'sim', status: 'available', guesthouse: guesthouse)

    booking_params = { booking: {check_in_date: "#{1.week.from_now}", check_out_date: "#{2.weeks.from_now}", guests_number: '2', room: room}}
    allow(Booking).to receive(:new).and_raise(ActiveRecord::ActiveRecordError) 

    #Act
    post "/api/v1/rooms/#{room.id}/bookings/check_availability", params: booking_params

    #Assert
    expect(response.status).to eq 500
  end
end