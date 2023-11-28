require 'rails_helper'

describe 'Usuário faz a busca de uma pousada' do
  it 'a partir do menu do cabeçalho sem estar autenticado' do
    #Arrange

    #Act
    visit root_path

    #Assert
    within('header nav form') do
      expect(page).to have_field 'Buscar Pousada'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e encontra uma pousada pelo seu nome fantasia' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                          phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                          neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                          description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                          user: paulo)

    #Act
    visit root_path
    fill_in 'Buscar Pousada', with: g.brand_name
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "Resultados da Busca por: #{g.brand_name}"
    expect(page).to have_content '1 pousada encontrada'
    expect(page).to have_link "#{g.brand_name}"
  end

  it 'e encontra uma pousada pelo seu bairro' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                          phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                          neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                          description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                          user: paulo)

    #Act
    visit root_path
    fill_in 'Buscar Pousada', with: g.neighborhood
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "Resultados da Busca por: #{g.neighborhood}"
    expect(page).to have_content '1 pousada encontrada'
    expect(page).to have_link "#{g.brand_name}"
  end

  it 'e encontra uma pousada pela sua cidade' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                          phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                          neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                          description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                          user: paulo)

    #Act
    visit root_path
    fill_in 'Buscar Pousada', with: g.city
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "Resultados da Busca por: #{g.city}"
    expect(page).to have_content '1 pousada encontrada'
    expect(page).to have_link "#{g.brand_name}"
  end

  it 'e não encontra uma pousada se ela estiver inativa' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'inactive',
                        user: paulo)

    #Act
    visit root_path
    fill_in 'Buscar Pousada', with: g.brand_name
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "Resultados da Busca por: #{g.brand_name}"
    expect(page).to have_content 'Nenhum resultado encontrado.'
  end

  it 'e encontra várias pousadas em ordem alfabética' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')

    g1 = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)
    g2 = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Recife', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: paulo)
    g3 = Guesthouse.create!(corporate_name: 'Pousada Aconchego Ltda', brand_name: 'Pousada Aconchego', registration_number:'78964526644545', 
                            phone_number: '8134587756', email: 'pousadaaconchego@gmail.com', address: 'Av. da Ribeira, 75', 
                            neighborhood: 'Boa Viagem', state: 'Pernambuco', city: 'Paulista', postal_code: '52680200', 
                            description: 'Pousada ótima', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)

    #Act
    visit root_path
    fill_in 'Buscar Pousada', with: 'Recife'
    click_on 'Buscar'

    #Assert
    expect(page).to have_content 'Resultados da Busca por: Recife'
    expect(page).to have_content '2 pousadas encontradas'
    links = all('ul li a')
    expect(links[0].text).to eq(g2.brand_name)
    expect(links[1].text).to eq(g1.brand_name)
    expect(links).not_to include(g3.brand_name)
  end

  it 'e ao clicar no link da pousada, vê os detalhes' do
    #Arrange
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                          phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                          neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                          description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                          user: mariana)

    #Act
    visit root_path
    fill_in 'Buscar Pousada', with: 'Recife'
    click_on 'Buscar'
    click_on 'Pousada Sulamericana'

    #Assert
    expect(current_path).to eq guesthouse_path(g.id)
    expect(page).to have_content 'Pousada Sulamericana'
    expect(page).to have_content 'Telefone para contato: 8138975644'
    expect(page).to have_content 'E-mail para contato: pousadasulamericana@gmail.com'
    expect(page).to have_content 'Endereço Completo: Av. Juliana Holanda, 498, Boa Vista, Recife - Pernambuco CEP: 54560500'
    expect(page).to have_content 'Descrição: Pousada com ótima localização'
    expect(page).to have_content 'Métodos de Pagamento: Dinheiro, pix e cartão'
    expect(page).to have_content 'Aceita animais de estimação? não'
    expect(page).to have_content 'Check-in: 13:00'
    expect(page).to have_content 'Check-out: 12:00'
  end
end