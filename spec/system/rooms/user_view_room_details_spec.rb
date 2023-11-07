require 'rails_helper'

describe 'Usuário vê detalhes de um quarto' do
  it 'e vê informacoes adicionais sem estar logado' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: paulo)
    r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)

    #Act
    visit root_path
    within('.guesthouses-list') do
      click_on 'Pousada Muro Alto'
    end
    click_on 'Quartos da Pousada'
    click_on 'Quarto Girassol'

    #Assert
    expect(page).to have_content 'Quarto Girassol'
    expect(page).to have_content 'Descrição: Quarto amplo com vista para o mar'
    expect(page).to have_content 'Área (m²): 10'
    expect(page).to have_content 'Quantidade max. de hóspedes: 4'
    expect(page).to have_content 'Valor padrão da diária: R$ 210,00'
    expect(page).to have_content 'Possui banheiro'
    expect(page).to have_content 'Possui ar-condicionado'
    expect(page).to have_content 'Possui tv'
    expect(page).to have_content 'Possui guarda-roupas'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
  end

  it 'e vê informacoes adicionais estando logado como anfitrião' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: paulo)
    r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)

    #Act
    login_as(paulo)
    visit root_path
    within('.guesthouses-list') do
      click_on 'Pousada Muro Alto'
    end
    click_on 'Quartos da Pousada'
    click_on 'Quarto Girassol'

    #Assert
    expect(page).to have_content 'Quarto Girassol'
    expect(page).to have_content 'Descrição: Quarto amplo com vista para o mar'
    expect(page).to have_content 'Área (m²): 10'
    expect(page).to have_content 'Quantidade max. de hóspedes: 4'
    expect(page).to have_content 'Valor padrão da diária: R$ 210,00'
    expect(page).to have_content 'Possui banheiro'
    expect(page).to have_content 'Possui ar-condicionado'
    expect(page).to have_content 'Possui tv'
    expect(page).to have_content 'Possui guarda-roupas'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
  end

  it 'e vê informacoes adicionais estando logado como hóspede' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'guest')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: paulo)
    r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)

    #Act
    login_as(mariana)
    visit root_path
    within('.guesthouses-list') do
      click_on 'Pousada Muro Alto'
    end
    click_on 'Quartos da Pousada'
    click_on 'Quarto Girassol'

    #Assert
    expect(page).to have_content 'Quarto Girassol'
    expect(page).to have_content 'Descrição: Quarto amplo com vista para o mar'
    expect(page).to have_content 'Área (m²): 10'
    expect(page).to have_content 'Quantidade max. de hóspedes: 4'
    expect(page).to have_content 'Valor padrão da diária: R$ 210,00'
    expect(page).to have_content 'Possui banheiro'
    expect(page).to have_content 'Possui ar-condicionado'
    expect(page).to have_content 'Possui tv'
    expect(page).to have_content 'Possui guarda-roupas'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
  end

  it 'e volta para a tela de listagem dos quartos da pousada' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: paulo)
    r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                    bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                    status: 'available', guesthouse: g)

    #Act
    visit root_path
    within('.guesthouses-list') do
      click_on 'Pousada Muro Alto'
    end
    click_on 'Quartos da Pousada'
    click_on 'Quarto Girassol'
    click_on 'Voltar'

    #Assert
    expect(current_path).to eq guesthouse_rooms_path(g.id)
  end
end