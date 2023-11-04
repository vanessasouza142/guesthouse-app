require 'rails_helper'

describe 'Usuário alfitrião edita sua pousada' do
  it 'a partir da página de detalhes' do
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
    click_on 'Editar'

    #Assert
    expect(page).to have_content 'Editar Pousada'
    expect(page).to have_field 'Razão Social', with: 'Pousada Muro Alto Ltda'
    expect(page).to have_field 'Nome Fantasia', with: 'Pousada Muro Alto'
    expect(page).to have_field 'CNPJ', with: '39165040000129'
    expect(page).to have_field 'Telefone para contato', with: '8134658799'
    expect(page).to have_field 'E-mail para contato', with: 'pousadamuroalto@gmail.com'
    expect(page).to have_field 'Endereço', with: 'Av. Beira Mar, 45'
  end

  it 'com sucesso' do
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
    click_on 'Editar'
    fill_in 'Razão Social', with: 'Pousada Muro Alto Beach Ltda'
    fill_in 'Telefone para contato', with: '8134658781'
    fill_in 'E-mail para contato', with: 'pousadamuroaltobeach@gmail.com'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Pousada atualizada com sucesso.'
    expect(page).to have_content 'Razão Social: Pousada Muro Alto Beach Ltda'
    expect(page).to have_content 'Telefone para contato: 8134658781'
    expect(page).to have_content 'E-mail para contato: pousadamuroaltobeach@gmail.com'
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
    click_on 'Editar'
    fill_in 'Razão Social', with: ''
    fill_in 'Telefone para contato', with: ''
    fill_in 'E-mail para contato', with: ''
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Pousada não atualizada.'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Telefone para contato não pode ficar em branco'
    expect(page).to have_content 'E-mail para contato não pode ficar em branco'
  end

  it 'e não a pousada de outro usuário anfitrião' do
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
    visit edit_guesthouse_path(g.id)

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end

  it 'e não um usuário do tipo hóspede' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'guest')

    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    
    #Act
    login_as(mariana)
    visit edit_guesthouse_path(g.id)

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end
end