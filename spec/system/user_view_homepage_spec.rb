require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome da aplicação' do
    #Arrange

    #Act
    visit root_path

    #Assert
    expect(page).to have_content('Pousadaria')
  end

  it 'e só vê as pousadas cadastradas ativas' do
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
    expect(page).not_to have_content 'Não existem pousadas cadastradas.'
    expect(page).to have_content 'Pousada Muro Alto'
    expect(page).to have_content 'Ipojuca'

    expect(page).to have_content 'Pousada Sulamericana'
    expect(page).to have_content 'Recife'

    expect(page).not_to have_content 'Pousada Aconchego'
    expect(page).not_to have_content 'Paulista'
  end

  it 'e não existem pousadas cadastradas ativas' do
    #Arrange

    #Act
    visit root_path

    #Assert
    expect(page).to have_content 'Não existem pousadas cadastradas.'
  end
end