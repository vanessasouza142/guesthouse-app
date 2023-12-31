require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presença obrigatória' do
      it 'falso quando nome está vazio' do
        #Arrange
        user = User.new(name: '', email: 'maria@gmail.com', cpf: '18598745698', password: 'password', role: 'guest')

        #Act
        result = user.valid?

        #Assert
        expect(result).to eq false
      end

      it 'falso quando cpf está vazio' do
        #Arrange
        user = User.new(name: 'Maria Barbosa', email: 'maria@gmail.com', cpf: '', password: 'password', role: 'guest')
        
        #Act

        #Assert
        expect(user).not_to be_valid
      end

      it 'falso quando perfil de cadastro está vazio' do
        #Arrange
        user = User.new(name: 'Maria Barbosa', email: 'maria@gmail.com', cpf: '18598745698', password: 'password', role: '')
        
        #Act

        #Assert
        expect(user).not_to be_valid
      end
    end
  end
end
