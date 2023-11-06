require 'rails_helper'

describe 'Usuário muda status da sua pousada' do
  it 'para ativa e ela aparece na listagem de pousadas' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'inactive',
                        user: paulo)
    
    #Act
    visit root_path
    login(paulo)
    click_on 'Pousada Muro Alto'
    click_on 'Ativar Pousada'

    #Assert
    expect(page).to have_content 'Pousada ativada com sucesso.'
    expect(page).to have_content 'Pousada Muro Alto'
    expect(page).to have_content 'Descrição: Pousada a beira mar maravilhosa'
    expect(page).to have_content 'Status: Ativa'
  end

  it 'para desativa e ela não aparece na listagem de pousadas' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                        user: paulo)
    
    #Act
    visit root_path
    login(paulo)
    click_on 'Pousada Muro Alto'
    click_on 'Desativar Pousada'

    #Assert
    expect(page).to have_content 'Pousada inativada com sucesso.'
    expect(page).to have_content 'Pousada Muro Alto'
    expect(page).to have_content 'Descrição: Pousada a beira mar maravilhosa'
    expect(page).to have_content 'Status: Inativa'
  end
end