# frozen_string_literal: true

descibe 'delete' do
  context 'when a registered user' do #bastante parecido com o get
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.remove(token, user.id) }

    it { expect(result.response.code).to eql '204' }
  end

  context 'when user not exists' do #mesma coisa do get
    let(:user) { build(:registered_user) } #vou logar com o user registrado
    let(:token) { ApiUser.token(user.email, user.password) } #vou pegar o token
    let(:result) { ApiUser.find(token, '0') } #mas aqui eu chamo o remove em vez do find
    it { expect(result.response.code).to eql '404' }
  end

  context 'when wrong id' do #mesma coisa do de cima
    let(:user) { build(:registered_user) } 
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.find(token, '0') } #mas aqui eu passo o id incorreto
    it { expect(result.response.code).to eql '412' } # e o codigo, claro
  end
end
