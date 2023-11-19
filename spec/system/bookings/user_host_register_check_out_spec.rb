require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Usuário anfitrião realiza check-out' do
  it 'ao acessar uma estadia ativa' do
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
    b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 1.week.from_now, guests_number: '1',
                        status: 'in_progress')

    #Act
    login_as(luiza)
    visit root_path
    b.update(check_in_done: Time.current)
    click_on 'Estadias Ativas'
    click_on "#{b.code}"

    #Assert
    expect(current_path).to eq booking_path(b.id)
    expect(page).to have_content "Estadia Ativa #{b.code}"
    expect(page).to have_content 'Quarto: Quarto Padrão'
    expect(page).to have_content 'Quantidade de hóspedes: 1'
    expect(page).to have_content 'Status: Em andamento'
    expect(page).to have_content "Check-in realizado em: #{I18n.l(b.check_in_done, format: '%d/%m/%Y, às %H:%M horas')}"
    expect(page).to have_button 'Realizar Check-out'
  end

  it 'com sucesso' do
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
    b = Booking.create!(room: r, user: mario, check_in_date: Date.today, check_out_date: 1.week.from_now, guests_number: '1',
                        status: 'in_progress')

    #Act
    login_as(luiza)
    visit root_path
    # b.update(check_in_done: Time.current)
    click_on 'Estadias Ativas'
    click_on "#{b.code}"
    click_on 'Realizar Check-out'

    #Assert
    expect(current_path).to eq payment_booking_path(b.id)
    expect(page).to have_content 'Check-out realizado com sucesso.'
    expect(page).to have_content "Check-out realizado em: "
    expect(page).to have_content "Período da hospedagem:"
    expect(page).to have_content 'Valor total a pagar: R$ '
    expect(page).to have_field 'Valor do Pagamento'
    expect(page).to have_field 'Método de Pagamento'
  end
end

#{I18n.l(Time.current, format: '%d/%m/%Y, às %H:%M horas')}
