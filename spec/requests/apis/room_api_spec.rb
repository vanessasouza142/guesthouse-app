require 'rails_helper'

describe 'Room API' do
  context 'GET /api/v1/guesthouses/1/rooms' do
    it 'lista quartos disponíveis de uma pousada' do
      #Arrange
      mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')
      guesthouse = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', 
                                    registration_number:'56897040000129', phone_number: '8138975644', email: 'pousadasulamericana@gmail.com',
                                    address: 'Av. Juliana Holanda, 498', neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', 
                                    postal_code: '54560500', description: 'Pousada com ótima localização', 
                                    payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                                    usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', 
                                    status: 'active', user: mariana)
      room1 = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                          bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', 
                          accessible: 'sim', status: 'available', guesthouse: guesthouse)
      room2 = Room.create!(name: 'Quarto Premium', description: 'Quarto maravilhoso', area: '13', max_guest: '4', default_price: '250,00',
                          bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'sim', 
                          accessible: 'sim', status: 'available', guesthouse: guesthouse)
      room3 = Room.create!(name: 'Quarto Single', description: 'Quarto simples', area: '8', max_guest: '1', default_price: '150,00',
                          bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'sim', 
                          accessible: 'sim', status: 'unavailable', guesthouse: guesthouse)

      #Act
      get "/api/v1/guesthouses/#{guesthouse.id}/rooms"

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["id"]).to eq 1
      expect(json_response[0]["name"]).to eq 'Quarto Padrão'
      expect(json_response[0]["description"]).to eq 'Quarto bem ventilado'
      expect(json_response[0]["area"]).to eq 10
      expect(json_response[0]["max_guest"]).to eq 2
      expect(json_response[0]["default_price"]).to eq 180
      expect(json_response[1]["id"]).to eq 2
      expect(json_response[1]["name"]).to eq 'Quarto Premium'
      expect(json_response[1]["description"]).to eq 'Quarto maravilhoso'
      expect(json_response[1]["area"]).to eq 13
      expect(json_response[1]["max_guest"]).to eq 4
      expect(json_response[1]["default_price"]).to eq 250
    end

    it 'retorna vazio se não tiver quartos cadastrados' do
      #Arrange
      mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')
      guesthouse = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', 
                                    registration_number:'56897040000129', phone_number: '8138975644', email: 'pousadasulamericana@gmail.com',
                                    address: 'Av. Juliana Holanda, 498', neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', 
                                    postal_code: '54560500', description: 'Pousada com ótima localização', 
                                    payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                                    usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', 
                                    status: 'active', user: mariana)

      #Act
      get "/api/v1/guesthouses/#{guesthouse.id}/rooms"

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'falha se tiver um erro interno' do
      #Arrange
      mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')
      guesthouse = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', 
                                    registration_number:'56897040000129', phone_number: '8138975644', email: 'pousadasulamericana@gmail.com',
                                    address: 'Av. Juliana Holanda, 498', neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', 
                                    postal_code: '54560500', description: 'Pousada com ótima localização', 
                                    payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                                    usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', 
                                    status: 'active', user: mariana)
                                    
      allow(Room).to receive(:all).and_raise(ActiveRecord::ActiveRecordError) 
  
      #Act
      get "/api/v1/guesthouses/#{guesthouse.id}/rooms"
  
      #Assert
      expect(response.status).to eq 500
    end
  end
end