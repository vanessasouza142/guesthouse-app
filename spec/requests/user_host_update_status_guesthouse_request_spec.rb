require 'rails_helper'

describe 'Usuário atualiza status de uma pousada' do
  it 'para ativa e não é o dono' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g1 = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                          phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                          neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                          description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'host')
    g2 = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)
    
    #Act
    login_as(mariana)
    post(activate_guesthouse_path(g1.id))

    #Assert
    expect(response).to redirect_to(root_path)
  end

  it 'para inativa e não é o dono' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    g1 = Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                          phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                          neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                          description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                          usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)

    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'host')
    g2 = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)
    
    #Act
    login_as(mariana)
    post(inactivate_guesthouse_path(g1.id))

    #Assert
    expect(response).to redirect_to(root_path)
  end
end