require 'rails_helper'

describe 'Usuário anfitrião registra uma pousada' do
  it 'e não está autenticado' do
    #Arrange
    
    #Act
    post(guesthouses_path)

    #Assert
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'e já tem uma pousada cadastrada' do
    #Arrange
    paulo = User.create!(name: 'Paulo Menezes', email: 'paulomenezes@gmail.com', password: 'password', role: 'host')
    Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: paulo)
    
    #Act
    login_as(paulo)
    post(guesthouses_path, params: { guesthouse: { corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', 
                                                    registration_number:'56897040000129', phone_number: '8138975644', 
                                                    email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                                                    neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                                                    description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', 
                                                    pet_agreement: 'não', usage_policy: 'Proibido fumar nas áreas de convivência', 
                                                    check_in: '13:00', check_out: '12:00'}})

    #Assert
    expect(response).to redirect_to(my_guesthouse_path)
  end

  it 'e um usuário hóspede tenta registrar uma pousada' do
    #Arrange
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'guest')
    
    #Act
    login_as(mariana)
    post(guesthouses_path, params: { guesthouse: { corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', 
                                                    registration_number:'56897040000129', phone_number: '8138975644', 
                                                    email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                                                    neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                                                    description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', 
                                                    pet_agreement: 'não', usage_policy: 'Proibido fumar nas áreas de convivência', 
                                                    check_in: '13:00', check_out: '12:00'}})

    #Assert
    expect(response).to redirect_to(root_path)
  end
end