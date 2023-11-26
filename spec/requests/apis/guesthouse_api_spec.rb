require 'rails_helper'

describe 'Guesthouse API' do
  context 'GET /api/v1/guesthouses' do
    it 'lista todas as pousadas cadastradas e ativas' do
      #Arrange
      paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
      mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'host')
      jose = User.create!(name: 'José Santana', email: 'jose@gmail.com', password: 'password', role: 'host')
      Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', 
                          registration_number:'39165040000129', phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', 
                          address: 'Av. Beira Mar, 45', neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', 
                          postal_code: '54350820', description: 'Pousada a beira mar maravilhosa', 
                          payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00',
                          status: 'inactive', user: paulo)
      Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', 
                          registration_number:'56897040000129', phone_number: '8138975644', email: 'pousadasulamericana@gmail.com',
                          address: 'Av. Juliana Holanda, 498', neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', 
                          postal_code: '54560500', description: 'Pousada com ótima localização', 
                          payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', 
                          status: 'active', user: mariana)
      Guesthouse.create!(corporate_name: 'Pousada Aconchego Ltda', brand_name: 'Pousada Aconchego', registration_number:'78964526644545', 
                          phone_number: '8134587756', email: 'pousadaaconchego@gmail.com', address: 'Av. da Ribeira, 75', 
                          neighborhood: 'Boa Viagem', state: 'Pernambuco', city: 'Paulista', postal_code: '52680200', 
                          description: 'Pousada ótima', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', 
                          status: 'active', user: jose)

      #Act
      get '/api/v1/guesthouses'

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["brand_name"]).to eq 'Pousada Sulamericana'
      expect(json_response[0]["city"]).to eq 'Recife'
      expect(json_response[1]["brand_name"]).to eq 'Pousada Aconchego'
      expect(json_response[1]["city"]).to eq 'Paulista'
    end

    it 'retorna vazio se não tem pousada cadastrada' do
      #Arrange

      #Act
      get '/api/v1/guesthouses'

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'filtra pousadas pelo nome' do
      #Arrange
      paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
      mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'host')
      jose = User.create!(name: 'José Santana', email: 'jose@gmail.com', password: 'password', role: 'host')
      Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', 
                          registration_number:'39165040000129', phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', 
                          address: 'Av. Beira Mar, 45', neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', 
                          postal_code: '54350820', description: 'Pousada a beira mar maravilhosa', 
                          payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00',
                          status: 'active', user: paulo)
      Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', 
                          registration_number:'56897040000129', phone_number: '8138975644', email: 'pousadasulamericana@gmail.com',
                          address: 'Av. Juliana Holanda, 498', neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', 
                          postal_code: '54560500', description: 'Pousada com ótima localização', 
                          payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', 
                          status: 'active', user: mariana)

      #Act
      get '/api/v1/guesthouses', params: { search: 'Sulamericana' }

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]["brand_name"]).to eq 'Pousada Sulamericana'
      expect(json_response[0]["city"]).to eq 'Recife'
    end

    it 'retorna vazio se não tem pousadas correspondentes à pesquisa' do
      #Arrange

      #Act
      get '/api/v1/guesthouses', params: { search: 'Sulamericana' }

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'falha se tiver um erro interno' do
      #Arrange
      allow(Guesthouse).to receive(:all).and_raise(ActiveRecord::ActiveRecordError) 
  
      #Act
      get '/api/v1/guesthouses'
  
      #Assert
      expect(response.status).to eq 500
    end
  end

  context 'GET /api/v1/guesthouses/1' do
    it 'mostra os detalhes de uma pousada (sem avaliações)' do
      #Arrange
      paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
      guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', 
                                      registration_number:'39165040000129', phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', 
                                      address: 'Av. Beira Mar, 45', neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', 
                                      postal_code: '54350820', description: 'Pousada a beira mar maravilhosa', 
                                      payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                                      usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00',
                                      status: 'active', user: paulo)

      #Act
      get "/api/v1/guesthouses/#{guesthouse.id}"

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'registration_number'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
      expect(json_response.keys).not_to include 'user_id'
      expect(json_response.keys).not_to include 'status'
      expect(json_response["brand_name"]).to eq 'Pousada Muro Alto'
      expect(json_response["phone_number"]).to eq '8134658799'
      expect(json_response["email"]).to eq 'pousadamuroalto@gmail.com'
      expect(json_response["address"]).to eq 'Av. Beira Mar, 45'
      expect(json_response["neighborhood"]).to eq 'Muro Alto'
      expect(json_response["state"]).to eq 'Pernambuco'
      expect(json_response["city"]).to eq 'Ipojuca'
      expect(json_response["postal_code"]).to eq '54350820'
      expect(json_response["description"]).to eq 'Pousada a beira mar maravilhosa'
      expect(json_response["payment_method"]).to eq 'Dinheiro, pix e cartão'
      expect(json_response["pet_agreement"]).to eq 'sim'
      expect(json_response["usage_policy"]).to eq 'Proibido fumar nas áreas de convivência'
      expect(json_response["check_in"]).to eq '13:00'
      expect(json_response["check_out"]).to eq '12:00'
      expect(json_response["average_score"]).to eq ''
    end

    it 'mostra os detalhes de uma pousada (com avaliações)' do
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

      guest1 = User.create!(name: 'Juliana Souza', email: 'juliana@gmail.com', password: 'password', role: 'guest')
      booking1 = Booking.create!(check_in_date: 7.weeks.ago, check_out_date: 6.weeks.ago, guests_number: '2', room: room, user: guest1,
                                  check_in_done: 7.weeks.ago, check_out_done: 6.weeks.ago, status: 'finished')
      review1 = Review.create!(score: '4.5', review_text: 'Ótima localização.', booking: booking1)
  
      guest2 = User.create!(name: 'Maria Albuquerque', email: 'maria@gmail.com', password: 'password', role: 'guest')
      booking2 = Booking.create!(check_in_date: 5.weeks.ago, check_out_date: 3.weeks.ago, guests_number: '1', room: room, user: guest2,
                                  check_in_done: 5.weeks.ago, check_out_done: 3.weeks.ago, status: 'finished')
      review2 = Review.create!(score: '3.0', review_text: 'Boa hospedagem mas pode melhorar.', booking: booking2)

      #Act
      get "/api/v1/guesthouses/#{guesthouse.id}"

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'registration_number'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
      expect(json_response.keys).not_to include 'user_id'
      expect(json_response.keys).not_to include 'status'
      expect(json_response["brand_name"]).to eq 'Pousada Muro Alto'
      expect(json_response["phone_number"]).to eq '8134658799'
      expect(json_response["email"]).to eq 'pousadamuroalto@gmail.com'
      expect(json_response["address"]).to eq 'Av. Beira Mar, 45'
      expect(json_response["neighborhood"]).to eq 'Muro Alto'
      expect(json_response["state"]).to eq 'Pernambuco'
      expect(json_response["city"]).to eq 'Ipojuca'
      expect(json_response["postal_code"]).to eq '54350820'
      expect(json_response["description"]).to eq 'Pousada a beira mar maravilhosa'
      expect(json_response["payment_method"]).to eq 'Dinheiro, pix e cartão'
      expect(json_response["pet_agreement"]).to eq 'sim'
      expect(json_response["usage_policy"]).to eq 'Proibido fumar nas áreas de convivência'
      expect(json_response["check_in"]).to eq '13:00'
      expect(json_response["check_out"]).to eq '12:00'
      expect(json_response["average_score"]).to eq 3.8
    end

    it 'falha se a pousada não existe' do
      #Arrange

      #Act
      get '/api/v1/guesthouses/999999'

      #Assert
      expect(response.status).to eq 404
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq 'Registro não encontrado'
    end

    it 'falha se a pousada existe mas está inativa' do
      #Arrange
      paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
      guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', 
                                      registration_number:'39165040000129', phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', 
                                      address: 'Av. Beira Mar, 45', neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', 
                                      postal_code: '54350820', description: 'Pousada a beira mar maravilhosa', 
                                      payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                                      usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00',
                                      status: 'inactive', user: paulo)
      #Act
      get "/api/v1/guesthouses/#{guesthouse.id}"

      #Assert
      expect(response.status).to eq 422
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq 'Pousada inativa no momento'
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
                                      status: 'inactive', user: paulo)

      allow(Guesthouse).to receive(:find).and_raise(ActiveRecord::ActiveRecordError) 
  
      #Act
      get "/api/v1/guesthouses/#{guesthouse.id}"
  
      #Assert
      expect(response.status).to eq 500
    end
  end
end