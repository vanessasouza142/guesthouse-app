require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe '#valid?' do
    context 'presença obrigatória' do
      it 'falso quando data de entrada está vazio' do
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
        booking = Booking.new(check_in_date: '', check_out_date: '10/01/2024', guests_number: '2')
        #Act

        #Assert
        expect(booking).not_to be_valid
      end

      it 'falso quando data de saída está vazio' do
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
        booking = Booking.new(check_in_date: '01/01/2024', check_out_date: '', guests_number: '2')
        #Act

        #Assert
        expect(booking).not_to be_valid
      end

      it 'falso quando quantidade de hóspedes está vazio' do
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
        booking = Booking.new(check_in_date: '01/01/2024', check_out_date: '10/01/2024', guests_number: '')
        #Act

        #Assert
        expect(booking).not_to be_valid
      end
    end

    context 'check_dates' do
      it 'já existe uma reserva para o quarto no periodo consultado' do
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

        guest = User.create!(name: 'João da Silva', email: 'joao@gmail.com', cpf: '33336543770', password: 'password', role: 'guest')
        booking1 = Booking.create!(check_in_date: '10/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r, user: guest)
        booking2 = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r)

        #Act
        booking2.valid?

        #Assert
        expect(booking2.errors.include?(:base)).to be true
        expect(booking2.errors[:base]).to include('O quarto não está disponível para o período selecionado.')
      end

      it 'não existe uma reserva para o quarto no periodo consultado' do
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

        booking = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r)

        #Act
        booking.valid?

        #Assert
        expect(booking.errors.include?(:base)).to be false
      end

      it 'data de entrada é posterior à data de saída' do
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

        booking = Booking.new(check_in_date: '15/12/2023', check_out_date: '12/12/2023', guests_number: '2', room: r)

        #Act
        booking.valid?

        #Assert
        expect(booking.errors.include?(:check_in_date)).to be true
        expect(booking.errors[:check_in_date]).to include(' deve ser anterior à data de saída')
      end

      it 'data de entrada é anterior à data de saída' do
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

        booking = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r)

        #Act
        booking.valid?

        #Assert
        expect(booking.errors.include?(:check_in_date)).to be false
      end
    end

    context 'check_guests_number' do
      it 'Quantidade de hóspedes da consulta é menor que a quantidade de hóspedes permitida do quarto' do
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

        booking2 = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '1', room: r)

        #Act
        booking2.valid?

        #Assert
        expect(booking2.errors.include?(:guests_number)).to be false
      end

      it 'Quantidade de hóspedes da consulta é igual a quantidade de hóspedes permitida do quarto' do
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

        booking2 = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '2', room: r)

        #Act
        booking2.valid?

        #Assert
        expect(booking2.errors.include?(:guests_number)).to be false
      end

      it 'Quantidade de hóspedes da consulta é maior que a quantidade de hóspedes permitida do quarto' do
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

        booking2 = Booking.new(check_in_date: '12/12/2023', check_out_date: '15/12/2023', guests_number: '3', room: r)

        #Act
        booking2.valid?

        #Assert
        expect(booking2.errors.include?(:guests_number)).to be true
        expect(booking2.errors[:guests_number]).to include(' ultrapassa o permitido para o quarto.')
      end
    end

    context 'generate_code' do
      it 'É gerado um código ao criar uma nova reserva' do
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
        booking = Booking.new(room: r, user: mario, check_in_date: 1.day.from_now, check_out_date: 5.days.from_now, guests_number: '1')

        #Act
        booking.save!
        result = booking.code

        #Assert
        expect(result).not_to be_empty
        expect(result.length).to eq 8
      end

      it 'e o código é único' do
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
        booking1 = Booking.create!(room: r, user: mario, check_in_date: 1.day.from_now, check_out_date: 5.days.from_now, guests_number: '1')
        booking2 = Booking.new(room: r, user: mario, check_in_date: 4.weeks.from_now, check_out_date: 5.weeks.from_now, guests_number: '1')

        #Act
        booking2.save!

        #Assert
        expect(booking2.code).not_to eq booking1.code
      end

      it 'e o código não deve ser modificado' do
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
        booking = Booking.create!(room: r, user: mario, check_in_date: 1.day.from_now, check_out_date: 5.days.from_now, guests_number: '1')
        original_code = booking.code

        #Act
        booking.update!(check_in_date: 2.days.from_now)

        #Assert
        expect(booking.code).to eq original_code
      end
    end

    context 'allow_check_in' do
      it 'O dia atual é anterior ao dia do check-in' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: 1.day.from_now, check_out_date: 5.days.from_now, guests_number: '1')

        # Act
        result = b.allow_check_in

        # Assert
        expect(result).to eq(false)
      end

      it 'O dia atual é igual ao dia do check-in' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 5.days.from_now, guests_number: '1')

        # Act
        result = b.allow_check_in

        # Assert
        expect(result).to eq(true)
      end

      it 'O dia atual é maior que o dia do check-in' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: 1.day.ago, check_out_date: 5.days.from_now, guests_number: '1')

        # Act
        result = b.allow_check_in

        # Assert
        expect(result).to eq(true)
      end
    end

    context 'calculate_total_price' do
      it 'calcula o valor total das diárias da consulta' do
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
        booking = Booking.new(room: r, check_in_date: 2.days.from_now, check_out_date: 4.days.from_now, guests_number: '1')

        #Act
        booking_total_price = booking.calculate_total_price

        #Assert
        expect(booking_total_price).to eq 360
      end

      it 'calcula o valor total das diárias da consulta e quarto tem preço personalizado' do
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
        cp = CustomPrice.create!(begin_date: 2.weeks.ago, end_date: 1.week.from_now, price: '350,00', room: r)

        booking = Booking.new(room: r, check_in_date: 2.days.from_now, check_out_date: 4.days.from_now, guests_number: '1')

        #Act
        booking_total_price = booking.calculate_total_price

        #Assert
        expect(booking_total_price).to eq 700
      end
    end

    context 'calculate_payment_amount' do
      it 'Calcula o valor do pagamento da hospedagem' do
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
        booking = Booking.create!(check_in_date: 1.week.ago, check_out_date: Date.today, guests_number: '2', room: r, user: mario,
                                  check_in_done: 1.week.ago, check_out_done: Date.today.change(hour: 11, minute: 30), status: 'finished')

        #Act
        booking_payment_amount = booking.calculate_payment_amount

        #Assert
        expect(booking_payment_amount).to eq 1260
      end
    end

    context 'host_cancel_booking' do
      it 'O dia atual é dois dias após o dia do checkin' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: 2.days.ago, check_out_date: 5.days.from_now, guests_number: '1')

        # Act
        result = b.host_cancel_booking

        # Assert
        expect(result).to eq(true)
      end

      it 'O dia atual é um dia após o dia do checkin' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: 1.day.ago, check_out_date: 5.days.from_now, guests_number: '1')

        # Act
        result = b.host_cancel_booking

        # Assert
        expect(result).to eq(false)
      end

      it 'O dia atual é igual ao dia do checkin' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 5.days.from_now, guests_number: '1')

        # Act
        result = b.host_cancel_booking

        # Assert
        expect(result).to eq(false)
      end
    end

    context 'guest_cancel_booking' do
      it 'O dia atual é oito dias antes do dia do checkin' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: 8.days.from_now, check_out_date: 10.days.from_now, guests_number: '1')

        # Act
        result = b.guest_cancel_booking

        # Assert
        expect(result).to eq(true)
      end

      it 'O dia atual é sete dias antes do dia do checkin' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: 7.days.from_now, check_out_date: 10.days.from_now, guests_number: '1')

        # Act
        result = b.guest_cancel_booking

        # Assert
        expect(result).to eq(true)
      end

      it 'O dia atual é seis dias antes do dia do checkin' do
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
        b = Booking.create!(room: r, user: mario, check_in_date: 6.days.from_now, check_out_date: 10.days.from_now, guests_number: '1')

        # Act
        result = b.guest_cancel_booking

        # Assert
        expect(result).to eq(false)
      end
    end
  end
end
