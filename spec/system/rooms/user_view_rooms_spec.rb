require 'rails_helper'

describe 'Usuário visita a pousada' do
  it 'e só vê os quartos cadastrados disponíveis' do
    #Arrange
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'host')

    g = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)
    r1 = Room.create!(name: 'Quarto Girassol', description: 'Quarto amplo com vista para o mar', area: '10', max_guest: '4', default_price: '210,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'sim', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'available', guesthouse: g)
    r2 = Room.create!(name: 'Quarto Tulipa', description: 'Quarto bem ventilado', area: '8', max_guest: '3', default_price: '180,00',
                      bathroom: 'sim', balcony: 'não', air_conditioner: 'sim', tv: 'não', wardrobe: 'sim', safe: 'não', accessible: 'sim',
                      status: 'unavailable',guesthouse: g)

    #Act
    visit root_path
    within('.guesthouses-list') do
      click_on 'Pousada Sulamericana'
    end
    click_on 'Quartos da Pousada'

    #Assert
    expect(page).not_to have_content 'Não existem quartos cadastrados.'
    expect(page).to have_content 'Quarto Girassol'
    expect(page).to have_content 'Descrição: Quarto amplo com vista para o mar'
    expect(page).to have_content 'Valor padrão da diária: R$ 210,00'

    expect(page).not_to have_content 'Quarto Tulipa'
    expect(page).not_to have_content 'Descrição: Quarto bem ventilado'
    expect(page).not_to have_content 'Valor padrão da diária: R$ 180,00'
end

  it 'e não existem quartos cadastrados disponíveis' do
    #Arrange
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'host')

    g = Guesthouse.create!(corporate_name: 'Pousada Sulamericana Ltda', brand_name: 'Pousada Sulamericana', registration_number:'56897040000129', 
                            phone_number: '8138975644', email: 'pousadasulamericana@gmail.com', address: 'Av. Juliana Holanda, 498', 
                            neighborhood: 'Boa Vista', state: 'Pernambuco', city: 'Recife', postal_code: '54560500', 
                            description: 'Pousada com ótima localização', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'não',
                            usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', status: 'active',
                            user: mariana)

    #Act
    visit root_path
    within('.guesthouses-list') do
      click_on 'Pousada Sulamericana'
    end
    click_on 'Quartos da Pousada'

    #Assert
    expect(page).to have_content 'Não existem quartos cadastrados.'
  end
end