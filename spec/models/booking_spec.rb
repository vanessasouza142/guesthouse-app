require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando data de entrada está vazio' do
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
        booking = Booking.new(check_in_date: '', check_out_date: '10/01/2024', guests_number: '2')
        #Act

        #Assert
        expect(booking).not_to be_valid
      end

      it 'falso quando data de saída está vazio' do
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
        booking = Booking.new(check_in_date: '01/01/2024', check_out_date: '', guests_number: '2')
        #Act

        #Assert
        expect(booking).not_to be_valid
      end

      it 'falso quando quantidade de hóspedes está vazio' do
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
        booking = Booking.new(check_in_date: '01/01/2024', check_out_date: '10/01/2024', guests_number: '')
        #Act

        #Assert
        expect(booking).not_to be_valid
      end
    end

    context 'check_dates' do
      it 'já existe uma reserva para o quarto no periodo consultado' do
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

        hospede = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
        booking1 = Booking.create!(check_in_date: '10/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r, user: hospede)
        booking2 = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r)

        #Act
        booking2.valid?

        #Assert
        expect(booking2.errors.include?(:base)).to be true
        expect(booking2.errors[:base]).to include('O quarto não está disponível para o período selecionado.')
      end

      it 'não existe uma reserva para o quarto no periodo consultado' do
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

        booking2 = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r)

        #Act
        booking2.valid?

        #Assert
        expect(booking2.errors.include?(:base)).to be false
      end
    end

    context 'check_guests_number' do
      it 'o Quantidade de hóspedes da consulta é menor que o Quantidade de hóspedes permitido do quarto' do
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

        booking2 = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '1', room: r)

        #Act
        booking2.valid?

        #Assert
        expect(booking2.errors.include?(:guests_number)).to be false
      end

      it 'o Quantidade de hóspedes da consulta é igual ao Quantidade de hóspedes permitido do quarto' do
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

        booking2 = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r)

        #Act
        booking2.valid?

        #Assert
        expect(booking2.errors.include?(:guests_number)).to be false
      end

      it 'o Quantidade de hóspedes da consulta é maior que o Quantidade de hóspedes permitido do quarto' do
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

        booking2 = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '3', room: r)

        #Act
        booking2.valid?

        #Assert
        expect(booking2.errors.include?(:guests_number)).to be true
        expect(booking2.errors[:guests_number]).to include(' ultrapassa o permitido para o quarto.')
      end
    end

    context 'allow_check_in' do
      it 'O dia atual é anterior ao dia do check-in' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: 1.day.from_now, check_out_date: 5.days.from_now, guests_number: '1')

        # Act
        result = b.allow_check_in

        # Assert
        expect(result).to eq(false)
      end

      it 'O dia atual é igual ao dia do check-in' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 5.days.from_now, guests_number: '1')

        # Act
        result = b.allow_check_in

        # Assert
        expect(result).to eq(true)
      end

      it 'O dia atual é maior que o dia do check-in' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: 1.day.ago, check_out_date: 5.days.from_now, guests_number: '1')

        # Act
        result = b.allow_check_in

        # Assert
        expect(result).to eq(true)
      end
    end

  end
end
