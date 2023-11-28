require 'rails_helper'

describe 'Usuário anfitrião vê lista de preços personalizados' do
  it 'ao ir na tela de detalhes de um quarto' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)
    cp = CustomPrice.create!(begin_date: '01/12/2023', end_date: '31/12/2023', price: '350,00', room: r)

    #Act
    login_as(paulo)
    visit my_guesthouse_path
    click_on 'Pousada Muro Alto'
    click_on 'Quarto Girassol'

    #Assert
    expect(page).to have_content 'Quarto Girassol'
    expect(page).to have_content 'Descrição: Quarto amplo com vista para o mar'
    expect(page).to have_content 'Área (m²): 10'
    expect(page).to have_content 'Lista de Preços Personalizados:'
    expect(page).to have_content 'Data de início: 01/12/2023 | Data de fim: 31/12/2023 | Valor personalizado da diária: R$ 350,00'
  end

  it 'vê mensagem caso não existam preços personalizados cadastrados' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)

    #Act
    login_as(paulo)
    visit my_guesthouse_path
    click_on 'Pousada Muro Alto'
    click_on 'Quarto Girassol'

    #Assert
    expect(page).to have_content 'Quarto Girassol'
    expect(page).to have_content 'Descrição: Quarto amplo com vista para o mar'
    expect(page).to have_content 'Área (m²): 10'
    expect(page).to have_content 'Não existem preços personalizados cadastrados.'
  end
end