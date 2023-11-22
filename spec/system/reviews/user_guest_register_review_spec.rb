require 'rails_helper'

describe 'Usuário hóspede registra uma avaliação' do
  # it 'e deve estar autenticado' do
  #   #Arrange
  #   hospede = User.create!(name: 'João da Silva', email: 'joao@gmail.com', password: 'password', role: 'guest')

  #   #Act
  #   visit 

  #   #Assert
  #   expect(current_path).to eq new_user_session_path

  # end

  it 'a partir da tela Minhas Reservas' do
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
    booking = Booking.create!(check_in_date: 2.weeks.ago, check_out_date: 1.week.ago, guests_number: '2', room: r, user: hospede,
                              check_in_done: 2.weeks.ago, check_out_done: 1.week.ago, status: 'finished')

    #Act
    login_as(hospede)
    visit root_path
    click_on 'Minhas Reservas'
    click_on "#{booking.code}"
    click_on 'Registrar Avaliação'

    #Assert
    expect(current_path).to eq new_booking_review_path(booking.id)
    expect(page).to have_content "Registrar Avaliação da Reserva #{booking.code}"
    expect(page).to have_field 'Nota'
    expect(page).to have_field 'Avaliação'
  end
end