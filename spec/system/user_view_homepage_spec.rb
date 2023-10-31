require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome da aplicação' do
    #Arrange

    #Act
    visit(root_path)

    #Assert
    expect(page).to have_content('Pousadaria')
  end
end