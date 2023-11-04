require 'rails_helper'

describe 'Usuário anfitrião cadastra uma pousada' do
  it 'depois de criar sua conta' do
    #Arrange

    #Act
    visit root_path
    host_sign_up

    #Assert
    expect(current_path).to eq new_guesthouse_path
    expect(page).to have_content 'Cadastrar Pousada'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Telefone para contato'
    expect(page).to have_field 'E-mail para contato'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'CEP'
  end

  it 'com sucesso' do
    #Arrange

    #Act
    visit root_path
    host_sign_up
    fill_in 'Razão Social', with: 'Pousada Muro Alto Ltda'
    fill_in 'Nome Fantasia', with: 'Pousada Muro Alto'
    fill_in 'CNPJ', with: '39165040000129'
    fill_in 'Telefone para contato', with: '8134658799'
    fill_in 'E-mail para contato', with: 'pousadamuroalto@gmail.com'
    fill_in 'Endereço', with: 'Av. Beira Mar, 45'
    fill_in 'Bairro', with: 'Muro Alto'
    fill_in 'Estado', with: 'Pernambuco'
    fill_in 'Cidade', with: 'Ipojuca'
    fill_in 'CEP', with: '54350820'
    fill_in 'Descrição', with: 'Pousada a beira mar maravilhosa'
    fill_in 'Métodos de Pagamento', with: 'Dinheiro, pix e cartão'
    fill_in 'Aceita animais de estimação?', with: 'sim'
    fill_in 'Politicas de Uso', with: 'Proibido fumar nas áreas de convivência'
    fill_in 'Check-in', with: '13:00'
    fill_in 'Check-out', with: '12:00'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Pousada cadastrada com sucesso.'
    expect(page).to have_content 'Pousada Muro Alto'
    expect(page).to have_content '39165040000129'
    expect(page).to have_content 'Av. Beira Mar, 45'
  end

  it 'com dados incompletos' do
    #Arrange

    #Act
    visit root_path
    host_sign_up
    fill_in 'Razão Social', with: 'Pousada Muro Alto Ltda'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Telefone para contato', with: '8134658799'
    fill_in 'E-mail para contato', with: 'pousadamuroalto@gmail.com'
    fill_in 'Endereço', with: 'Av. Beira Mar, 45'
    fill_in 'Bairro', with: 'Muro Alto'
    fill_in 'Estado', with: 'Pernambuco'
    fill_in 'Cidade', with: ''
    fill_in 'CEP', with: '54350820'
    fill_in 'Descrição', with: 'Pousada a beira mar maravilhosa'
    fill_in 'Métodos de Pagamento', with: ''
    fill_in 'Aceita animais de estimação?', with: 'sim'
    fill_in 'Politicas de Uso', with: 'Proibido fumar nas áreas de convivência'
    fill_in 'Check-in', with: '13:00'
    fill_in 'Check-out', with: '12:00'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Pousada não cadastrada.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Métodos de Pagamento não pode ficar em branco'
  end

  it 'e não um usuário do tipo hóspede' do
    #Arrange

    #Act
    visit root_path
    guest_sign_up
    visit new_guesthouse_path

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para realizar essa ação!'
  end

  it 'e não consegue cadastrar outra pousada' do
    #Arrange
    mariana = User.create!(name: 'Mariana Silva', email: 'mariana@gmail.com', password: 'password', role: 'host')
    Guesthouse.create!(corporate_name: 'Pousada Muro Alto Ltda', brand_name: 'Pousada Muro Alto', registration_number:'39165040000129', 
                        phone_number: '8134658799', email: 'pousadamuroalto@gmail.com', address: 'Av. Beira Mar, 45', 
                        neighborhood: 'Muro Alto', state: 'Pernambuco', city: 'Ipojuca', postal_code: '54350820', 
                        description: 'Pousada a beira mar maravilhosa', payment_method: 'Dinheiro, pix e cartão', pet_agreement: 'sim',
                        usage_policy: 'Proibido fumar nas áreas de convivência', check_in: '13:00', check_out: '12:00', user: mariana)

    #Act
    login_as(mariana)
    visit new_guesthouse_path

    #Assert
    expect(current_path).to eq my_guesthouse_path
    expect(page).to have_content 'Só é possível ter uma pousada cadastrada por usuário!'
  end

  # it 'e não consegue ir para outra tela sem antes concluir o cadastro' do

  # end

end