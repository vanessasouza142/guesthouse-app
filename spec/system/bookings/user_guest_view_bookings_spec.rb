require 'rails_helper'

describe 'Usuário hóspede vê as reservas agendadas e finalizadas' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit my_bookings_path

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'ao acessar o menu Minhas Reservas' do
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
    b1 = Booking.create!(room: r, user: mario, check_in_date: 5.weeks.ago, check_out_date: 4.weeks.ago, guests_number: '1',
                        check_in_done: 5.weeks.ago, check_in_done: 4.weeks.ago, status: 'finished')
    b2 = Booking.create!(room: r, user: mario, check_in_date: 6.weeks.from_now, check_out_date: 7.weeks.from_now, guests_number: '1')

    #Act
    login_as(mario)
    visit root_path
    click_on 'Minhas Reservas'

    #Assert
    expect(current_path).to eq my_bookings_path
    expect(page).to have_content 'Minhas Reservas'
    within('section:contains("Reservas Pendentes") thead') do
      expect(page).to have_content 'Código da Reserva'
      expect(page).to have_content 'Pousada'
      expect(page).to have_content 'Quarto'
      expect(page).to have_content 'Data de entrada'
      expect(page).to have_content 'Data de saída'
      expect(page).to have_content 'Quantidade de hóspedes'
    end
    within('section:contains("Reservas Pendentes") tbody') do
      expect(page).to have_content "#{b2.code}"
      expect(page).to have_content "#{r.name}"
      expect(page).to have_content "#{g.brand_name}"
      expect(page).to have_content "#{I18n.l(b2.check_in_date, format: "%d/%m/%Y")}"
      expect(page).to have_content "#{I18n.l(b2.check_out_date, format: "%d/%m/%Y")}"
      expect(page).to have_content "#{b2.guests_number}"
    end
    within('section:contains("Reservas Finalizadas") thead') do
      expect(page).to have_content 'Código da Reserva'
      expect(page).to have_content 'Pousada'
      expect(page).to have_content 'Quarto'
      expect(page).to have_content 'Data de entrada'
      expect(page).to have_content 'Data de saída'
      expect(page).to have_content 'Quantidade de hóspedes'
    end
    within('section:contains("Reservas Finalizadas") tbody') do
      expect(page).to have_content "#{b1.code}"
      expect(page).to have_content "#{r.name}"
      expect(page).to have_content "#{g.brand_name}"
      expect(page).to have_content "#{I18n.l(b1.check_in_date, format: "%d/%m/%Y")}"
      expect(page).to have_content "#{I18n.l(b1.check_out_date, format: "%d/%m/%Y")}"
      expect(page).to have_content "#{b1.guests_number}"
    end
  end

  it 'e vê mensagem caso não existam reservas' do
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

    #Act
    login_as(mario)
    visit root_path
    click_on 'Minhas Reservas'

    #Assert
    expect(current_path).to eq my_bookings_path
    expect(page).to have_content 'Minhas Reservas'
    expect(page).to have_content 'Você não tem reservas pendentes no momento.'
    expect(page).to have_content 'Você não tem reservas finalizadas no momento.'
  end
end