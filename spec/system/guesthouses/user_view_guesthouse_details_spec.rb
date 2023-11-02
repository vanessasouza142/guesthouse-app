require 'rails_helper'

describe 'Usuário vê detalhes de uma pousada' do
  it 'e vê informacoes adicionais sem estar logado' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    #Act
    visit root_path
    click_on 'Pousada Muro Alto'

    #Assert
    expect(page).to have_content 'Pousada Muro Alto'
    expect(page).to have_content 'Razão Social: Pousada Muro Alto Ltda'
    expect(page).to have_content 'CNPJ: 39165040000129'
    expect(page).to have_content 'E-mail para contato: pousadamuroalto@gmail.com'
    expect(page).to have_content 'Endereço Completo: Av. Beira Mar, 45, Muro Alto, Ipojuca - Pernambuco CEP: 54350820'
  end

  it 'e volta para a tela inicial' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    
    #Act
    visit root_path
    click_on 'Pousada Muro Alto'
    click_on 'Voltar'

    #Assert
    expect(current_path).to eq(root_path)
  end
end