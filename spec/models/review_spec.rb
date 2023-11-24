require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando Nota está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        status: 'available', guesthouse: g)        
        guest = User.create!(name: 'Juliana Souza', email: 'juliana@gmail.com', password: 'password', role: 'guest')
        booking = Booking.create!(check_in_date: 7.weeks.ago, check_out_date: 6.weeks.ago, guests_number: '2', room: r, user: guest)
        review = Review.new(score: '', review_text: 'Ótima localização.', booking: booking)

        #Act

        #Assert
        expect(review).not_to be_valid
      end

      it 'falso quando Avaliação está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                        status: 'available', guesthouse: g)        
        guest = User.create!(name: 'Juliana Souza', email: 'juliana@gmail.com', password: 'password', role: 'guest')
        booking = Booking.create!(check_in_date: 7.weeks.ago, check_out_date: 6.weeks.ago, guests_number: '2', room: r, user: guest)
        review = Review.new(score: '', review_text: 'Ótima localização.', booking: booking)

        #Act

        #Assert
        expect(review).not_to be_valid
      end

      it 'falso quando Resposta está vazio' do
        #Arrange
        paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
        g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
        r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
        bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
        status: 'available', guesthouse: g)
        
        guest = User.create!(name: 'Juliana Souza', email: 'juliana@gmail.com', password: 'password', role: 'guest')
        booking = Booking.create!(check_in_date: 7.weeks.ago, check_out_date: 6.weeks.ago, guests_number: '2', room: r, user: guest,
                                    check_in_done: 7.weeks.ago, check_out_done: 6.weeks.ago, status: 'finished')
        review = Review.create!(score: '4.5', review_text: 'Ótima localização.', booking: booking)

        # Act
        review.update(score: '4.5', review_text: 'Ótima localização.', answer: '', booking: booking)

        # Assert
        expect(review).not_to be_valid
      end
    end
  end
end
