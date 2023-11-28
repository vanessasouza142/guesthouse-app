require 'rails_helper'

describe 'Usuário alfitrião edita um quarto da sua pousada' do
  it 'e deve estar autenticado' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)
    #Act
    visit edit_room_path(r)

    #Arrange
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da página de detalhes do quarto' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                  bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                  status: 'available', guesthouse: g)
    
    #Act
    login_as(paulo)
    visit my_guesthouse_path
    click_on 'Pousada Muro Alto'
    click_on 'Quarto Girassol'
    click_on 'Editar'

    #Assert
    expect(page).to have_content 'Editar Quarto'
    expect(page).to have_field 'Nome', with: 'Quarto Girassol'
    expect(page).to have_field 'Descrição', with: 'Quarto amplo com vista para o mar'
    expect(page).to have_field 'Área (m²)', with: '10'
    expect(page).to have_field 'Quantidade max. de hóspedes', with: '4'
    expect(page).to have_field 'Valor da diária', with: '210'
    expect(page).to have_field 'Possui banheiro'
    expect(page).to have_field 'Possui varanda'
    expect(page).to have_field 'Possui ar-condicionado'
    expect(page).to have_field 'Possui tv'
    expect(page).to have_field 'Possui guarda-roupas'
    expect(page).to have_field 'Possui cofre'
    expect(page).to have_field 'Acessível para pessoas com deficiência'
  end

  it 'com sucesso' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                  bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                  status: 'available', guesthouse: g)
    
    #Act
    login_as(paulo)
    visit my_guesthouse_path
    click_on 'Pousada Muro Alto'
    click_on 'Quarto Girassol'
    click_on 'Editar'
    fill_in 'Nome', with: '102 - Quarto Girassol'
    fill_in 'Descrição', with: 'Quarto amplo e ventilado com vista para o mar'
    uncheck 'Possui ar-condicionado'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Quarto atualizado com sucesso.'
    expect(page).to have_content '102 - Quarto Girassol'
    expect(page).to have_content 'Descrição: Quarto amplo e ventilado com vista para o mar'
    expect(page).not_to have_content 'Possui ar-condicionado'
  end

  it 'com dados incompletos' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                  bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                  status: 'available', guesthouse: g)
    
    #Act
    login_as(paulo)
    visit my_guesthouse_path
    click_on 'Pousada Muro Alto'
    click_on 'Quarto Girassol'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Quarto não atualizado.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end

  it 'e não um usuário anfitrião diferente' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g1 = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      guesthouse: g1)

    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')
    g2 = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)

    #Act
    login_as(mariana)
    visit edit_room_path(r.id)

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end

  it 'e não um usuário do tipo hóspede' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    carla = User.create!(name: 'Carla Oliveira', email: 'carla@gmail.com', cpf: '48682787547', password: 'password', role: 'guest')

    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    r = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'sim', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      guesthouse: g)

    #Act
    login_as(carla)
    visit edit_room_path(r.id)

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end
end