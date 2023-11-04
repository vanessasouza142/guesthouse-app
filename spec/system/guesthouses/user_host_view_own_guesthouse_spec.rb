require 'rails_helper'

describe 'Usuário anfitrião vê sua pousada' do
  it 'depois de fazer login' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    
    #Act
    visit root_path
    login(paulo)

    #Assert
    expect(current_path).to eq my_guesthouse_path
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_content 'Pousada Muro Alto'
    expect(page).to have_content 'Descrição: Pousada a beira mar maravilhosa'
    expect(page).to have_content 'Ipojuca - Pernambuco'
  end

  it 'ou através do link Minha Pousada' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    
    #Act
    visit root_path
    login(paulo)
    click_on 'Pousada Muro Alto'
    click_on 'Minha Pousada'

    #Assert
    expect(current_path).to eq my_guesthouse_path
    expect(page).to have_content 'Pousada Muro Alto'
    expect(page).to have_content 'Descrição: Pousada a beira mar maravilhosa'
    expect(page).to have_content 'Ipojuca - Pernambuco'
  end

  it 'e não vê pousada de outro usuário anfitrião' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'host')

    g1 = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                            phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                            neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                            description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    g2 = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: mariana)
    #Act
    visit root_path
    login(mariana)

    #Assert
    expect(current_path).to eq my_guesthouse_path
    expect(page).to have_content 'Pousada Sulamericana'
    expect(page).to have_content 'Descrição: Pousada com ótima localização'
    expect(page).to have_content 'Recife - Pernambuco'

    expect(page).not_to have_content 'Pousada Muro Alto'
    expect(page).not_to have_content 'Descrição: Pousada a beira mar maravilhosa'
    expect(page).not_to have_content 'Ipojuca - Pernambuco'
  end
end