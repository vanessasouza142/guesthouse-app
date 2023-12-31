require 'rails_helper'

describe 'Usuário vê menu de cidades que tem pousadas cadastradas ativas' do
  it 'com sucesso na homepage' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')

    g1 = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: paulo)
    g2 = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)
    g3 = Guesthouse.create!(corporate_name: 'Pousada Aconchego Ltda', brand_name: 'Pousada Aconchego', registration_number:'78964526644545', 
                            phone_number: '8134587756', email: 'pousadaaconchego@gmail.com', address: 'Av. da Ribeira, 75', 
                            neighborhood: 'Boa Viagem', state: 'Pernambuco', city: 'Paulista', postal_code: '52680200', 
                            description: 'Pousada ótima', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'inactive',
                            user: mariana)

    #Act
    visit root_path

    #Assert
    expect(page).to have_content 'Menu de Cidades'
    within('.menu-cities') do
      expect(page).to have_content 'Ipojuca'
      expect(page).to have_content 'Recife'
      expect(page).not_to have_content 'Paulista'
    end
  end

  it 'e ao clicar em uma cidade do menu, encontra as pousadas dessa cidade em ordem alfabética' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', cpf: '25248794021', password: 'password', role: 'host')
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', cpf: '05238660464', password: 'password', role: 'host')

    g1 = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)
    g2 = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
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
    within('.menu-cities') do
      click_on 'Ipojuca'
    end

    #Assert
    expect(current_path).to eq guesthouses_by_city_path(g1.city)
    expect(page).not_to have_content 'Não existem pousadas cadastradas.'
    expect(page).to have_content 'Pousadas em Ipojuca:'
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
                          neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54560500', 
                          description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                          user: mariana)

    #Act
    visit root_path
    within('.menu-cities') do
      click_on 'Ipojuca'
    end
    click_on 'Pousada Sulamericana'

    #Assert
    expect(current_path).to eq guesthouse_path(g.id)
    expect(page).to have_content 'Pousada Sulamericana'
    expect(page).to have_content 'Telefone para contato: 8138975644'
    expect(page).to have_content 'E-mail para contato: pousadasulamericana@gmail.com'
    expect(page).to have_content 'Endereço Completo: Av. Juliana Holanda, 498, Boa Vista, Ipojuca - Pernambuco CEP: 54560500'
    expect(page).to have_content 'Descrição: Pousada com ótima localização'
    expect(page).to have_content 'Métodos de Pagamento: Dinheiro, pix e cartão'
    expect(page).to have_content 'Aceita animais de estimação? não'
    expect(page).to have_content 'Check-in: 13:00'
    expect(page).to have_content 'Check-out: 12:00'
  end
end