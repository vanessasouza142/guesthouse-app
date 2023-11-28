require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#valid?' do
    context 'presença obrigatória' do
      it 'falso quando Nome está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.new(name: '', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        #Act

        #Assert
        expect(room).not_to be_valid
      end

      it 'falso quando Descrição está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.new(name: 'Quarto Girassol', description: '', area: '10', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        #Act

        #Assert
        expect(room).not_to be_valid
      end

      it 'falso quando Área está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.new(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        #Act

        #Assert
        expect(room).not_to be_valid
      end

      it 'falso quando Quantidade max. de hóspedes está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.new(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '', default_price: '210,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        #Act

        #Assert
        expect(room).not_to be_valid
      end

      it 'falso quando Valor da diária está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.new(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        #Act

        #Assert
        expect(room).not_to be_valid
      end
    end
  end

  describe '#current_daily_price(date)' do
    it 'Altera o valor da diária do quarto se houver um preço personalizado no período' do
      #Arrange
      paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
      g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                              phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                              neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                              description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                              usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
      r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        status: 'available', guesthouse: g)
      cp = CustomPrice.create!(begin_date: Date.today, end_date: 1.week.from_now, price: '350,00', room: r)

      #Act
      room_price = r.current_daily_price(Date.today)

      #Assert
      expect(room_price).to eq 350
    end

    it 'Valor da diária do quarto não muda se não houver um preço personalizado no período' do
      #Arrange
      paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
      g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                              phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                              neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                              description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                              usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
      r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        status: 'available', guesthouse: g)

      #Act
      room_price = r.current_daily_price(Date.today)

      #Assert
      expect(room_price).to eq 210
    end
  end
end
