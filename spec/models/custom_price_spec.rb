require 'rails_helper'

RSpec.describe CustomPrice, type: :model do
  describe '#valid?' do
    context 'presença obrigatória' do
      it 'falso quando data de início está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        custom_price = CustomPrice.new(begin_date: '', end_date: '31/12/2023', price: '350,00', room: room)
        #Act

        #Assert
        expect(custom_price).not_to be_valid
      end

      it 'falso quando data de fim está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        custom_price = CustomPrice.new(begin_date: '01/12/2023', end_date: '', price: '350,00', room: room)
        #Act

        #Assert
        expect(custom_price).not_to be_valid
      end

      it 'falso quando preço da diária está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        custom_price = CustomPrice.new(begin_date: '01/12/2023', end_date: '31/12/2023', price: '', room: room)
        #Act

        #Assert
        expect(custom_price).not_to be_valid
      end
    end

    context '#no_date_overlap' do
      it 'já existe um preço personalizado para o período' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                          bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                          guesthouse: g)
        first_cp = CustomPrice.create!(begin_date: '01/12/2023', end_date: '31/12/2023', price: '250,00', room: room)
        second_cp = CustomPrice.new(begin_date: '10/12/2023', end_date: '15/12/2023', price: '350,00', room: room)

        #Act
        second_cp.valid?

        #Assert
        expect(second_cp.errors.include?(:base)).to be true
        expect(second_cp.errors[:base]).to include("Já existe um preço personalizado para o quarto nesse período")
      end

      it 'não existe um preço personalizado para o período' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                          bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                          guesthouse: g)
        cp = CustomPrice.new(begin_date: '10/12/2023', end_date: '15/12/2023', price: '350,00', room: room)

        #Act
        cp.valid?

        #Assert
        expect(cp.errors.include?(:base)).to be false
      end
    end

    context '#dates_order' do
      it 'a data de início é posterior à data de término' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        first_cp = CustomPrice.new(begin_date: '10/12/2023', end_date: '05/12/2023', price: '350,00', room: room)

        #Act
        first_cp.valid?

        #Assert
        expect(first_cp.errors.include?(:begin_date)).to be true
        expect(first_cp.errors[:begin_date]).to include(' deve ser anterior à data de término')
      end

      it 'a data de início é anterior à data de término' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        guesthouse: g)
        first_cp = CustomPrice.new(begin_date: '05/12/2023', end_date: '10/12/2023', price: '350,00', room: room)

        #Act
        first_cp.valid?

        #Assert
        expect(first_cp.errors.include?(:begin_date)).to be false
      end
    end
  end
end
