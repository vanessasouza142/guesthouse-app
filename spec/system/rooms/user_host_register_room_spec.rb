require 'rails_helper'

describe 'Usuário anfitrião cadastra um quarto na sua pousada' do
  it 'e deve estar autenticado' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    #Act
    visit new_guesthouse_room_path(g)

    #Arrange
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da tela de detalhes da pousada' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    #Act
    login_as(paulo)
    visit my_guesthouse_path
    click_on 'Pousada Muro Alto'
    click_on 'Cadastrar novo Quarto'

    #Assert
    expect(current_path).to eq new_guesthouse_room_path(guesthouse)
    expect(page).to have_content 'Cadastrar Quarto'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Área (m²)'
    expect(page).to have_field 'Quantidade max. de hóspedes'
    expect(page).to have_field 'Valor da diária'
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
    guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    #Act
    login_as(paulo)
    visit my_guesthouse_path
    click_on 'Pousada Muro Alto'
    click_on 'Cadastrar novo Quarto'
    fill_in 'Nome', with: 'Quarto Girassol'
    fill_in 'Descrição', with: 'Quarto amplo com vista para o mar'
    fill_in 'Área (m²)', with: '10'
    fill_in 'Quantidade max. de hóspedes', with: '4'
    fill_in 'Valor da diária', with: '210,00'
    check 'Possui banheiro'
    uncheck 'Possui varanda'
    check 'Possui ar-condicionado'
    check 'Possui tv'
    check 'Possui guarda-roupas'
    uncheck 'Possui cofre'
    check 'Acessível para pessoas com deficiência'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Quarto cadastrado com sucesso.'
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

  it 'com dados incompletos' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    #Act
    login_as(paulo)
    visit my_guesthouse_path
    click_on 'Pousada Muro Alto'
    click_on 'Cadastrar novo Quarto'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Área (m²)', with: ''
    fill_in 'Quantidade max. de hóspedes', with: ''
    fill_in 'Valor da diária', with: ''
    check 'Possui banheiro'
    uncheck 'Possui varanda'
    check 'Possui ar-condicionado'
    check 'Possui tv'
    check 'Possui guarda-roupas'
    uncheck 'Possui cofre'
    check 'Acessível para pessoas com deficiência'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Quarto não cadastrado.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Área (m²) não pode ficar em branco'
    expect(page).to have_content 'Quantidade max. de hóspedes não pode ficar em branco'
    expect(page).to have_content 'Valor da diária não pode ficar em branco'
  end

  it 'e não um usuário anfitrião diferente' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g1 = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')
    g2 = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)
    
    #Act
    login_as(mariana)
    visit new_guesthouse_room_path(g1.id)

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end

  it 'e não um usuário do tipo hóspede' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    carla = User.create!(name: 'Carla Oliveira', email: 'carla@gmail.com', cpf: '48682787547', password: 'password', role: 'guest')
    g1 = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    #Act
    login_as(carla)
    visit new_guesthouse_room_path(g1.id)

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end
end