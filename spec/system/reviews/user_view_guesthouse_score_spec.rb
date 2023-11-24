require 'rails_helper'

describe 'Usuário visualiza nota média da pousada' do
  it 'sem estar autenticado' do
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

    hospede1 = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
    booking1 = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: hospede1,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review1 = Review.create!(score: '4.2', review_text: 'Hospedagem maravilhosa', booking: booking1)

    hospede2 = User.create!(name: 'Maria Albuquerque', email: 'maria@gmail.com', password: 'password', role: 'guest')
    booking2 = Booking.create!(check_in_date: 5.weeks.ago, check_out_date: 3.weeks.ago, guests_number: '1', room: r, user: hospede2,
                              check_in_done: 5.weeks.ago, check_out_done: 3.weeks.ago, status: 'finished')
    review2 = Review.create!(score: '3.0', review_text: 'Boa hospedagem mas pode melhorar.', booking: booking2)

    #Act
    visit root_path
    click_on 'Pousada Ouro Branco'

    #Assert
    expect(current_path).to eq guesthouse_path(g.id)
    expect(page).to have_content 'Nota Média: 3,6'
  end

  it 'estando autenticado como hóspede' do
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

    hospede1 = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
    booking1 = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: hospede1,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review1 = Review.create!(score: '4.2', review_text: 'Hospedagem maravilhosa', booking: booking1)

    hospede2 = User.create!(name: 'Maria Albuquerque', email: 'maria@gmail.com', password: 'password', role: 'guest')
    booking2 = Booking.create!(check_in_date: 5.weeks.ago, check_out_date: 3.weeks.ago, guests_number: '1', room: r, user: hospede2,
                              check_in_done: 5.weeks.ago, check_out_done: 3.weeks.ago, status: 'finished')
    review2 = Review.create!(score: '3.0', review_text: 'Boa hospedagem mas pode melhorar.', booking: booking2)

    #Act
    login_as(hospede1)
    visit root_path
    click_on 'Pousada Ouro Branco'

    #Assert
    expect(current_path).to eq guesthouse_path(g.id)
    expect(page).to have_content 'Nota Média: 3,6'
  end

  it 'estando autenticado como anfitrião' do
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

    hospede1 = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')
    booking1 = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: hospede1,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review1 = Review.create!(score: '4.2', review_text: 'Hospedagem maravilhosa', booking: booking1)

    hospede2 = User.create!(name: 'Maria Albuquerque', email: 'maria@gmail.com', password: 'password', role: 'guest')
    booking2 = Booking.create!(check_in_date: 5.weeks.ago, check_out_date: 3.weeks.ago, guests_number: '1', room: r, user: hospede2,
                              check_in_done: 5.weeks.ago, check_out_done: 3.weeks.ago, status: 'finished')
    review2 = Review.create!(score: '3.0', review_text: 'Boa hospedagem mas pode melhorar.', booking: booking2)

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Pousada Ouro Branco'

    #Assert
    expect(current_path).to eq guesthouse_path(g.id)
    expect(page).to have_content 'Nota Média: 3,6'
  end
end