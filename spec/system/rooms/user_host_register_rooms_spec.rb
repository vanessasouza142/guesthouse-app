require 'rails_helper'

describe 'Usuário anfitrião cadastra um quarto na sua pousada' do
  it 'a partir da tela de detalhes da pousada' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    #Act
    visit root_path
    login(paulo)
    click_on 'Pousada Muro Alto'
    click_on 'Cadastrar novo quarto'

    #Assert
    expect(current_path).to eq new_guesthouse_room_path(guesthouse)
    expect(page).to have_content 'Cadastrar Quarto'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Área'
    expect(page).to have_field 'Quantidade max. de hóspedes'
    expect(page).to have_field 'Valor padrão da diária'
    expect(page).to have_field 'Possui banheiro?'
    expect(page).to have_field 'Possui varanda?'
    expect(page).to have_field 'Possui ar-condicionado?'
    expect(page).to have_field 'Possui tv?'
    expect(page).to have_field 'Possui guarda-roupas?'
    expect(page).to have_field 'Possui cofre?'
    expect(page).to have_field 'É acessível para pessoas com deficiência?'
  end

  it 'com sucesso' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    guesthouse = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    #Act
    visit root_path
    login(paulo)
    click_on 'Pousada Muro Alto'
    click_on 'Cadastrar novo quarto'
    fill_in 'Nome', with: 'Quarto Girassol'
    fill_in 'Descrição', with: 'Quarto amplo com vista para o mar'
    fill_in 'Área', with: '10 m²'
    fill_in 'Quantidade max. de hóspedes', with: '4'
    fill_in 'Valor padrão da diária', with: '210,00'
    fill_in 'Possui banheiro?', with: 'sim'
    fill_in 'Possui varanda?', with: 'não'
    fill_in 'Possui ar-condicionado?', with: 'sim'
    fill_in 'Possui tv?', with: 'sim'
    fill_in 'Possui guarda-roupas?', with: 'sim'
    fill_in 'Possui cofre?', with: 'não'
    fill_in 'É acessível para pessoas com deficiência?', with: 'sim'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Quarto cadastrado com sucesso.'
    expect(page).to have_content 'Quarto Girassol'
    expect(page).to have_content 'Descrição: Quarto amplo com vista para o mar'
    expect(page).to have_content 'Valor padrão da diária: R$ 210,00'
    expect(page).to have_content 'Possui varanda?: não'
    expect(page).to have_content 'Possui cofre?: não'
    expect(page).to have_content 'É acessível para pessoas com deficiência?: sim'
  end

  it 'com dados incompletos' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    #Act
    visit root_path
    login(paulo)
    click_on 'Pousada Muro Alto'
    click_on 'Cadastrar novo quarto'
    fill_in 'Nome', with: 'Quarto Girassol'
    fill_in 'Descrição', with: ''
    fill_in 'Área', with: '10 m²'
    fill_in 'Quantidade max. de hóspedes', with: ''
    fill_in 'Valor padrão da diária', with: '210,00'
    fill_in 'Possui banheiro?', with: ''
    fill_in 'Possui varanda?', with: 'não'
    fill_in 'Possui ar-condicionado?', with: 'sim'
    fill_in 'Possui tv?', with: 'sim'
    fill_in 'Possui guarda-roupas?', with: ''
    fill_in 'Possui cofre?', with: 'não'
    fill_in 'É acessível para pessoas com deficiência?', with: 'sim'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Quarto não cadastrado.'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Quantidade max. de hóspedes não pode ficar em branco'
    expect(page).to have_content 'Possui banheiro? não pode ficar em branco'
    expect(page).to have_content 'Possui guarda-roupas? não pode ficar em branco'
  end

  it 'e não um usuário anfitrião diferente' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'host')

    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    
    #Act
    login_as(mariana)
    visit new_guesthouse_room_path(g.id)

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end
end