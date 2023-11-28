require 'rails_helper'

describe 'Usuário prossegue com a reserva depois de ver disponibilidade do quarto' do
  it 'e cria sua conta como hóspede' do
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

    #Act
    visit root_path
    click_on 'Pousada Ouro Branco'
    click_on 'Quarto Padrão'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: '10/12/2023'
    fill_in 'Data de saída', with: '15/12/2023'
    fill_in 'Quantidade de hóspedes', with: '2'
    click_on 'Consultar'
    click_on 'Prosseguir com a Reserva'
    guest_sign_up

    #Assert
    expect(current_path).to eq confirm_booking_path
    expect(page).to have_content 'Resumo da Reserva'
    expect(page).to have_content 'Quarto escolhido: Quarto Padrão'
    expect(page).to have_content 'Data de entrada: 10/12/2023 - Horário de checkin: 14:00'
    expect(page).to have_content 'Data de saída: 15/12/2023 - Horário de checkout: 12:00'
    expect(page).to have_content 'Valor total das diárias: R$ 900,00'
    expect(page).to have_content 'Meios de pagamento aceitos pela pousada: Dinheiro, pix e cartão'
    expect(page).to have_content 'Após a reserva ser confirmada, ela pode ser cancelada até 7 dias antes da data agendada para o check-in.'
    expect(page).to have_button 'Confirmar Reserva'
  end

  it 'e faz login como hóspede' do
    #Arrange
    mario = User.create!(name: 'Mario Barbosa', email: 'mario@gmail.com', cpf: '70661435660', password: 'password', role: 'guest')

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

    #Act
    visit root_path
    click_on 'Pousada Ouro Branco'
    click_on 'Quarto Padrão'
    click_on 'Reservar'
    fill_in 'Data de entrada', with: '10/12/2023'
    fill_in 'Data de saída', with: '15/12/2023'
    fill_in 'Quantidade de hóspedes', with: '2'
    click_on 'Consultar'
    click_on 'Prosseguir com a Reserva'
    within ('.sign_in') do
      click_on 'Entrar na Conta'
    end
    fill_in 'E-mail', with: 'mario@gmail.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    #Assert
    expect(current_path).to eq confirm_booking_path
    expect(page).to have_content 'Resumo da Reserva'
    expect(page).to have_content 'Quarto escolhido: Quarto Padrão'
    expect(page).to have_content 'Data de entrada: 10/12/2023 - Horário de checkin: 14:00'
    expect(page).to have_content 'Data de saída: 15/12/2023 - Horário de checkout: 12:00'
    expect(page).to have_content 'Valor total das diárias: R$ 900,00'
    expect(page).to have_content 'Meios de pagamento aceitos pela pousada: Dinheiro, pix e cartão'
    expect(page).to have_content 'Após a reserva ser confirmada, ela pode ser cancelada até 7 dias antes da data agendada para o check-in.'
    expect(page).to have_button 'Confirmar Reserva'
  end
end