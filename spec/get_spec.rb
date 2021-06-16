# frozen_string_literal: true

describe 'get' do
  context 'when a registered user' do
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.find(token, user.id) }
    let(:user_db) { Database.new.find_user(user.email) }

    it { expect(result.response.code).to eql '200' }
    it { expect(result.parsed_response['full_name']).to eql user_db['full_name'] }
    it { expect(result.parsed_response['password']).to eql user_db['password'] }
    it { expect(result.parsed_response['email']).to eql user_db['email'] }
    it { expect(Time.parse(result.parsed_response['createdAt'])).to eql Time.parse(user_db['created_at']) }
    it { expect(Time.parse(result.parsed_response['updatedAt'])).to eql Time.parse(user_db['updated_at']) }
  end

  context 'when a not found user' do
    let(:user) { build(:registered_user) } #vou logar com o user registrado
    let(:token) { ApiUser.token(user.email, user.password) } #vou pegar o token
    let(:result) { ApiUser.find(token, '0') } #mas aqui eu vou passar um id que nao existe
    it { expect(result.response.code).to eql '404' }
  end

  context 'when a wrong id user' do
    let(:user) { build(:registered_user) }
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.find(token, 'id_invalido') } # aqui eu vou passar um id fora do padrao
    it { expect(result.response.code).to eql '412' }
  end

  context 'when other id' do
    let(:user) { build(:registered_user) } #vou logar com o user do contexto
    let(:other_user) { build(:registered_user) } #vou gerar outro usuario
    let(:token) { ApiUser.token(user.email, user.password) }
    let(:result) { ApiUser.find(token, other_user.id) } # vou fazer a busca do id do outro usuario que nao eh o user que gerou o token
    it { expect(result.response.code).to eql '401' } # deve dar nao autorizado
  end
end

# context 'when a registered user' do
#   let(:user) { build(:user_duplicate_email) } #perceba que ja temos um factory cadastrado aqui
#   let(:token) { ApiUser.token(user.email, user.password) } #este let jah devolve o valor do token
#   let(:result) { ApiUser.find(token, user.id) } #pegaremos o id dele, entao, mas a API precisa do token, entao passe o token tambem
#   let(:user_data) { Database.new.find_user(user.email)} #pegue os dados cadastrados do usuario

#   it { expect(result.response.code).to eql '200' } #eh preciso validar campos alem do token
#   it { expect(result.parsed_response["full_name"]).to eql user_data["full_name"] } #aqui eh para fazer a consulta para saber se os dados chegaram certo no banco
#   it { expect(result.parsed_response['email']).to eql user_data['email'] }
#   it { expect(result.parsed_response['password']).to eql user_data['password'] }
#   # it { expect(result.parsed_response['createdAt']).to eql user_data['createdAt'] } #a API tem camel case e o bd snake case, este codigo vai dar errado
#   it { expect(Time.parse(result.parsed_response['createdAt'])).to eql Time.parse(user_data['created_at']) } #converto para o formato de data do ruby
#   it { expect(Time.parse(result.parsed_response['updateAt'])).to eql Time.parse(user_data['update_at']) }
# end
