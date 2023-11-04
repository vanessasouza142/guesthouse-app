def guest_sign_up
  within('nav') do
    click_on 'Entrar na Conta'
  end
  click_on 'Criar Conta'
  within('form') do
    fill_in 'Nome', with: 'Maria Barbosa'
    fill_in 'E-mail', with: 'maria@example.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    select 'Hóspede', from: 'Perfil de Cadastro'
    click_on 'Criar'
  end
end

def host_sign_up
  within('nav') do
    click_on 'Entrar na Conta'
  end
  click_on 'Criar Conta'
  within('form') do
    fill_in 'Nome', with: 'Julio Almeida'
    fill_in 'E-mail', with: 'julio@example.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    select 'Anfitrião', from: 'Perfil de Cadastro'
    click_on 'Criar'
  end
end
