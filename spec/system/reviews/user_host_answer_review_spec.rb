require 'rails_helper'

describe 'Usuário anfitrião responde avaliação da sua pousada' do
  it 'e deve estar autenticado' do
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
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review = Review.create!(score: '4,2', review_text: 'Hospedagem maravilhosa', booking: booking)

    #Act
    visit answer_review_path(review.id)

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu Avaliações' do
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
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review = Review.create!(score: '4,2', review_text: 'Hospedagem maravilhosa', booking: booking)

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Avaliações'
    click_on booking.code
    click_on 'Responder Avaliação'

    #Assert
    expect(current_path).to eq answer_review_path(review.id)
    expect(page).to have_content "Responder Avaliação da Hospedagem #{booking.code}"
    expect(page).to have_field 'Resposta'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do
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
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review = Review.create!(score: '4,2', review_text: 'Hospedagem maravilhosa', booking: booking)

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Avaliações'
    click_on booking.code
    click_on 'Responder Avaliação'
    fill_in 'Resposta', with: 'Obrigado pela avaliação.'
    click_on 'Salvar'

    #Assert
    expect(current_path).to eq booking_path(booking.id)
    expect(page).to have_content 'Resposta registrada com sucesso.'
    expect(page).to have_content 'Resposta: Obrigado pela avaliação.'
  end

  it 'com dado incompleto' do
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
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review = Review.create!(score: '4,2', review_text: 'Hospedagem maravilhosa', booking: booking)

    #Act
    login_as(luiza)
    visit my_guesthouse_path
    click_on 'Avaliações'
    click_on booking.code
    click_on 'Responder Avaliação'
    fill_in 'Resposta', with: ''
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Resposta não registrada.'
    expect(page).to have_content 'Resposta não pode ficar em branco'
  end

  it 'e usuário hóspede visualiza resposta' do
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
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review = Review.create!(score: '4,2', review_text: 'Hospedagem maravilhosa', booking: booking, answer: 'Obrigado pela avaliação')

    #Act
    login_as(guest)
    visit root_path
    click_on 'Minhas Reservas'
    click_on booking.code

    #Assert
    expect(current_path).to eq booking_path(booking.id)
    expect(page).to have_content 'Resposta: Obrigado pela avaliação'
  end

  it 'e não um usuário anfitrião diferente' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', cpf: '38573169346', password: 'password', role: 'host')
    g1 = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                          phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                          neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                          description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                          user: luiza)
    r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                    bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                    status: 'available', guesthouse: g1)

    guest = User.create!(name: 'João da Silva', email: 'joao@gmail.com', cpf: '33336543770', password: 'password', role: 'guest')
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review = Review.create!(score: '4,2', review_text: 'Hospedagem maravilhosa', booking: booking, answer: 'Obrigado pela avaliação')

    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')
    g2 = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)

    #Act
    login_as(mariana)
    visit answer_review_path(review.id)

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end

  it 'e não um usuário um usuário do tipo hóspede' do
    #Arrange
    luiza = User.create!(name: 'Luiza Souza', email: 'luiza@gmail.com', cpf: '38573169346', password: 'password', role: 'host')
    g1 = Guesthouse.create!(corporate_name: 'Pousada Ouro Branco Ltda', brand_name: 'Pousada Ouro Branco', registration_number:'45789800129', 
                          phone_number: '11998756542', email: 'pousadaourobranco@gmail.com', address: 'Rua Santos Dumont, 65', 
                          neighborhood: 'Centro', state: 'Rio de Janeiro', city: 'Rio de Janeiro', postal_code: '27120-100', 
                          description: 'Pousada muito bem localizada', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '14:00', check_out: '12:00', status:'active',
                          user: luiza)
    r = Room.create!(name: 'Quarto Padrão', description: 'Quarto bem ventilado', area: '10', max_guest: '2', default_price: '180,00',
                    bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                    status: 'available', guesthouse: g1)

    guest = User.create!(name: 'João da Silva', email: 'joao@gmail.com', cpf: '33336543770', password: 'password', role: 'guest')
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: guest,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')
    review = Review.create!(score: '4,2', review_text: 'Hospedagem maravilhosa', booking: booking, answer: 'Obrigado pela avaliação')

    carla = User.create!(name: 'Carla Oliveira', email: 'carla@gmail.com', cpf: '48682787547', password: 'password', role: 'guest')

    #Act
    login_as(carla)
    visit answer_review_path(review.id)

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end
end