require 'rails_helper'

describe 'Usuário anfitrião cadastra preço personalizado para um quarto' do
  it 'a partir da tela de detalhes do quarto' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)

    #Act
    login_as(paulo)
    visit my_guesthouse_path
    click_on 'Pousada Muro Alto'
    click_on 'Quartos da Pousada'
    click_on 'Quarto Girassol'
    click_on 'Cadastrar novo Preço Personalizado'

    #Assert
    expect(current_path).to eq new_room_custom_price_path(room)
    expect(page).to have_content 'Cadastrar Preço Personalizado'
    expect(page).to have_field 'Data de início'
    expect(page).to have_field 'Data de fim'
    expect(page).to have_field 'Valor da diária'
  end

  it 'com sucesso' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)

    #Act
    login_as(paulo)
    visit room_path(room)    
    click_on 'Cadastrar novo Preço Personalizado'
    fill_in 'Data de início', with: '01/12/2023'
    fill_in 'Data de fim', with: '31/12/2023'
    fill_in 'Valor da diária', with: '350,00'
    click_on 'Salvar'

    #Assert
    expect(current_path).to eq room_path(room)
    expect(page).to have_content 'Preço personalizado cadastrado com sucesso.'
    expect(page).to have_content 'Lista de Preços Personalizados:'
    expect(page).to have_content 'Data de início: 01/12/2023'
    expect(page).to have_content 'Data de fim: 31/12/2023'
    expect(page).to have_content 'Valor da diária: R$ 350,00'
  end

  it 'com dados incompletos' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    room = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)

    #Act
    login_as(paulo)
    visit room_path(room)    
    click_on 'Cadastrar novo Preço Personalizado'
    fill_in 'Data de início', with: ''
    fill_in 'Data de fim', with: ''
    fill_in 'Valor da diária', with: ''
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Preço personalizado não cadastrado.'
    expect(page).to have_content 'Data de início não pode ficar em branco'
    expect(page).to have_content 'Data de fim não pode ficar em branco'
    expect(page).to have_content 'Valor da diária não pode ficar em branco'
  end
end