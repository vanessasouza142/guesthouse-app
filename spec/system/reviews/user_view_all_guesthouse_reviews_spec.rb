require 'rails_helper'

describe 'Usuário visualiza todas as avaliações recebidas da pousada' do
  it 'sem estar autenticado' do
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

    guest1 = User.create!(name: 'Juliana Souza', email: 'juliana@gmail.com', cpf: '02163471578', password: 'password', role: 'guest')
    booking1 = Booking.create!(check_in_date: 7.weeks.ago, check_out_date: 6.weeks.ago, guests_number: '2', room: r, user: guest1,
                                check_in_done: 7.weeks.ago, check_out_done: 6.weeks.ago, status: 'finished')
    review1 = Review.create!(score: '4.5', review_text: 'Ótima localização.', booking: booking1)

    guest2 = User.create!(name: 'Maria Albuquerque', email: 'maria@gmail.com', cpf: '37443612095', password: 'password', role: 'guest')
    booking2 = Booking.create!(check_in_date: 5.weeks.ago, check_out_date: 3.weeks.ago, guests_number: '1', room: r, user: guest2,
                                check_in_done: 5.weeks.ago, check_out_done: 3.weeks.ago, status: 'finished')
    review2 = Review.create!(score: '3.0', review_text: 'Boa hospedagem mas pode melhorar.', booking: booking2)

    guest3 = User.create!(name: 'João da Silva', email: 'joao@gmail.com', cpf: '33336543770', password: 'password', role: 'guest')
    booking3 = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest3,
                                check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review3 = Review.create!(score: '4.2', review_text: 'Hospedagem maravilhosa.', booking: booking3)

    guest4 = User.create!(name: 'André Barbosa', email: 'andre@gmail.com', cpf: '65830157144', password: 'password', role: 'guest')
    booking4 = Booking.create!(check_in_date: 3.days.ago, check_out_date: 1.day.ago, guests_number: '2', room: r, user: guest4,
                                check_in_done: 3.days.ago, check_out_done: 1.day.ago, status: 'finished')
    review4 = Review.create!(score: '4.8', review_text: 'Adorei a estadia.', booking: booking4)

    #Act
    visit root_path
    click_on 'Pousada Ouro Branco'
    click_on 'Ver mais avaliações'

    #Assert
    expect(current_path).to eq all_reviews_guesthouse_path(g.id)
    expect(page).to have_content 'Juliana Souza | Nota: 4,5 | Avaliação: Ótima localização.'
    expect(page).to have_content 'Maria Albuquerque | Nota: 3,0 | Avaliação: Boa hospedagem mas pode melhorar.'
    expect(page).to have_content 'João da Silva | Nota: 4,2 | Avaliação: Hospedagem maravilhosa.'
    expect(page).to have_content 'André Barbosa | Nota: 4,8 | Avaliação: Adorei a estadia.'
  end

  it 'estando autenticado como hóspede' do
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

    guest1 = User.create!(name: 'Juliana Souza', email: 'juliana@gmail.com', cpf: '02163471578', password: 'password', role: 'guest')
    booking1 = Booking.create!(check_in_date: 7.weeks.ago, check_out_date: 6.weeks.ago, guests_number: '2', room: r, user: guest1,
                                check_in_done: 7.weeks.ago, check_out_done: 6.weeks.ago, status: 'finished')
    review1 = Review.create!(score: '4.5', review_text: 'Ótima localização.', booking: booking1)

    guest2 = User.create!(name: 'Maria Albuquerque', email: 'maria@gmail.com', cpf: '37443612095', password: 'password', role: 'guest')
    booking2 = Booking.create!(check_in_date: 5.weeks.ago, check_out_date: 3.weeks.ago, guests_number: '1', room: r, user: guest2,
                                check_in_done: 5.weeks.ago, check_out_done: 3.weeks.ago, status: 'finished')
    review2 = Review.create!(score: '3.0', review_text: 'Boa hospedagem mas pode melhorar.', booking: booking2)

    guest3 = User.create!(name: 'João da Silva', email: 'joao@gmail.com', cpf: '33336543770', password: 'password', role: 'guest')
    booking3 = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest3,
                                check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review3 = Review.create!(score: '4.2', review_text: 'Hospedagem maravilhosa.', booking: booking3)

    guest4 = User.create!(name: 'André Barbosa', email: 'andre@gmail.com', cpf: '65830157144', password: 'password', role: 'guest')
    booking4 = Booking.create!(check_in_date: 3.days.ago, check_out_date: 1.day.ago, guests_number: '2', room: r, user: guest4,
                                check_in_done: 3.days.ago, check_out_done: 1.day.ago, status: 'finished')
    review4 = Review.create!(score: '4.8', review_text: 'Adorei a estadia.', booking: booking4)

    #Act
    login_as(guest4)
    visit root_path
    click_on 'Pousada Ouro Branco'
    click_on 'Ver mais avaliações'

    #Assert
    expect(current_path).to eq all_reviews_guesthouse_path(g.id)
    expect(page).to have_content 'Juliana Souza | Nota: 4,5 | Avaliação: Ótima localização.'
    expect(page).to have_content 'Maria Albuquerque | Nota: 3,0 | Avaliação: Boa hospedagem mas pode melhorar.'
    expect(page).to have_content 'João da Silva | Nota: 4,2 | Avaliação: Hospedagem maravilhosa.'
    expect(page).to have_content 'André Barbosa | Nota: 4,8 | Avaliação: Adorei a estadia.'
  end

  it 'estando autenticado como anfitrião' do
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

    guest1 = User.create!(name: 'Juliana Souza', email: 'juliana@gmail.com', cpf: '02163471578', password: 'password', role: 'guest')
    booking1 = Booking.create!(check_in_date: 7.weeks.ago, check_out_date: 6.weeks.ago, guests_number: '2', room: r, user: guest1,
                                check_in_done: 7.weeks.ago, check_out_done: 6.weeks.ago, status: 'finished')
    review1 = Review.create!(score: '4.5', review_text: 'Ótima localização.', booking: booking1)

    guest2 = User.create!(name: 'Maria Albuquerque', email: 'maria@gmail.com', cpf: '37443612095', password: 'password', role: 'guest')
    booking2 = Booking.create!(check_in_date: 5.weeks.ago, check_out_date: 3.weeks.ago, guests_number: '1', room: r, user: guest2,
                                check_in_done: 5.weeks.ago, check_out_done: 3.weeks.ago, status: 'finished')
    review2 = Review.create!(score: '3.0', review_text: 'Boa hospedagem mas pode melhorar.', booking: booking2)

    guest3 = User.create!(name: 'João da Silva', email: 'joao@gmail.com', cpf: '33336543770', password: 'password', role: 'guest')
    booking3 = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest3,
                                check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review3 = Review.create!(score: '4.2', review_text: 'Hospedagem maravilhosa.', booking: booking3)

    guest4 = User.create!(name: 'André Barbosa', email: 'andre@gmail.com', cpf: '65830157144', password: 'password', role: 'guest')
    booking4 = Booking.create!(check_in_date: 3.days.ago, check_out_date: 1.day.ago, guests_number: '2', room: r, user: guest4,
                                check_in_done: 3.days.ago, check_out_done: 1.day.ago, status: 'finished')
    review4 = Review.create!(score: '4.8', review_text: 'Adorei a estadia.', booking: booking4)

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Pousada Ouro Branco'
    click_on 'Ver mais avaliações'

    #Assert
    expect(current_path).to eq all_reviews_guesthouse_path(g.id)
    expect(page).to have_content 'Juliana Souza | Nota: 4,5 | Avaliação: Ótima localização.'
    expect(page).to have_content 'Maria Albuquerque | Nota: 3,0 | Avaliação: Boa hospedagem mas pode melhorar.'
    expect(page).to have_content 'João da Silva | Nota: 4,2 | Avaliação: Hospedagem maravilhosa.'
    expect(page).to have_content 'André Barbosa | Nota: 4,8 | Avaliação: Adorei a estadia.'
  end
end