# frozen_string_literal: true

describe 'post' do
  context 'when new user' do
    let(:result) { ApiUser.save(build(:user).to_hash) }
    it { expect(result.response.code).to eql '200' }
  end

  context 'when duplicate email' do
    let(:result) { ApiUser.save(build(:registered_user).to_hash) }
    it { expect(result.response.code).to eql '409' }
    it { expect(result.parsed_response['msg']).to eql 'Oops. Looks like you already have an account with this email address.' }
  end

  context 'when worong email' do
    let(:result) { ApiUser.save(build(:user_wrong_email).to_hash) }
    it { expect(result.response.code).to eql '412' }
    it { expect(result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
  end

  context 'when empty name' do
    let(:result) { ApiUser.save(build(:user_empty_name).to_hash) }
    it { expect(result.response.code).to eql '412' }
    it { expect(result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
  end

  context 'when empty email' do
    let(:result) { ApiUser.save(build(:user_empty_email).to_hash) }
    it { expect(result.response.code).to eql '412' }
    it { expect(result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
  end

  context 'when empty passowrd' do
    let(:result) { ApiUser.save(build(:user_empty_password).to_hash) }
    it { expect(result.response.code).to eql '412' }
    it { expect(result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
  end
end

# describe 'post' do
#   context 'when new user' do
#     # before do
#     #   new_user = build(:user).to_hash
#     #   @result = ApiUser.save(new_user)
#     # end

#     #o let deixa o codigo mais limpo e soh sera usado ao ser consumido pelo it
#     #o let soh sera chamado se invocado
    
#     # let(:new_user) { build(:user).to_hash } #como ele soh e usado aqui, pode ser usado diretamente no save
#     let(:result) { ApiUser.save(build(:user).to_hash) } #ele vai retornar o resultado do POST
#     it { expect(@result.response.code).to eql '200' }
#   end

#   context 'when duplicate email' do
#     before do
#       new_user = build(:user_duplicate_email).to_hash
#       @result = ApiUser.save(new_user) #ele vai tentar salvar de novo e nao conseguira
#     end
#     it { expect(@result.response.code).to eql '409' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. Looks like you already have an account with this email address.' }
#   end

#   context 'when worong email' do
#     before do
#       new_user = build(:user_wrong_email).to_hash
#       @result = ApiUser.save(new_user)
#     end
#     it { expect(@result.response.code).to eql '412' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
#   end

#   context 'when empty name' do
#     before do
#       new_user = build(:user_empty_name).to_hash
#       @result = ApiUser.save(new_user)
#     end
#     it { expect(@result.response.code).to eql '412' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
#   end

#   context 'when empty email' do
#     before do
#       new_user = build(:user_empty_email).to_hash
#       @result = ApiUser.save(new_user)
#     end
#     it { expect(@result.response.code).to eql '412' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
#   end

#   context 'when empty passowrd' do
#     before do
#       new_user = build(:user_empty_password).to_hash
#       @result = ApiUser.save(new_user)
#     end
#     it { expect(@result.response.code).to eql '412' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
#   end

# end
# describe 'post' do
#   context 'when new user' do
#     before do
#       new_user = build(:user).to_hash 
#       @result = ApiUser.save(new_user) #agora chamo meu service, que eh uma camada de abstracao
#     end
#     it { expect(@result.response.code).to eql '200' }
#   end

#   context 'when duplicate email' do
#     before do
#       new_user = build(:user_duplicate_email).to_hash
#       @result = ApiUser.save(new_user) #ele vai tentar salvar de novo e nao conseguira
#     end
#     it { expect(@result.response.code).to eql '409' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. Looks like you already have an account with this email address.' }
#   end

#   context 'when worong email' do
#     before do
#       new_user = build(:user_wrong_email).to_hash
#       @result = ApiUser.save(new_user)
#     end
#     it { expect(@result.response.code).to eql '412' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
#   end

#   context 'when empty name' do
#     before do
#       new_user = build(:user_empty_name).to_hash
#       @result = ApiUser.save(new_user)
#     end
#     it { expect(@result.response.code).to eql '412' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
#   end

#   context 'when empty email' do
#     before do
#       new_user = build(:user_empty_email).to_hash
#       @result = ApiUser.save(new_user)
#     end
#     it { expect(@result.response.code).to eql '412' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
#   end

#   context 'when empty passowrd' do
#     before do
#       new_user = build(:user_empty_password).to_hash
#       @result = ApiUser.save(new_user)
#     end
#     it { expect(@result.response.code).to eql '412' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }
#   end


# end

# describe 'post' do
#   context 'when new user' do
#     before do
#       @new_user = build(:user).to_hash #note que new user nao esta sendo utilizada alem de dentro do before, logo, nao precisa ser de instancia
#       @result = HTTParty.post(
#         'http://127.0.0.1:3001/user', #este codigo do before se repete bastante entao 
#         body: @new_user.to_json, #vamos criar a camada de servico do projeto que realizara esta acao
#         headers: {
#           'Content-Type' => 'application/json'
#         }
#       )
#     end
#     it { expect(@result.response.code).to eql '200' }
#   end

#   context 'when worong email' do
#     before do
#       @new_user = build(:user_wrong_email).to_hash # a fabrica user_wrong_email precisa ser criada
#       @result = HTTParty.post(
#         'http://127.0.0.1:3001/user',
#         body: @new_user.to_json,
#         headers: {
#           'Content-Type' => 'application/json'
#         }
#       )
#       #antes se eu colocasse apenas @result ele diria que era do tipo HTTParty::response
#       # a partir do momento em que coloco .parsed_response ele converte para saida valida que
#        # eh o formato hash do ruby e, ao passar o 'msg' eu pego o campo exato que quero fazer minha validacao
      
#        #puts @result.parsed_response['msg']
#     end
#     it { expect(@result.response.code).to eql '412' }
#     it { expect(@result.parsed_response['msg']).to eql 'Oops. You entered a wrong email.' }

#   end
# end

# describe 'post' do
#   context 'when new user' do
#     before do
#       @new_user = build(:user).to_hash
#       #este delete nao sera mais necessario pois ele sera hookado dentro do factory no after
#       #Database.new.delete_user(@new_user[:email])
#       @result = HTTParty.post(
#       'http://127.0.0.1:3001/user',
#       body: @new_user.to_json,
#       headers: {
#         "Content-Type" => "application/json"
#       },
#       )
#     end
#     it{expect(@result.response.code).to eql '200'}
#   end
# end

# describe 'post' do
#   context 'when new user' do #deixe em ingles por formalizacao
#     before do
#       #primeiro vou definir minha massa de testes
#       @new_user = build(:user).to_hash #eu quero buildar a fabrica que estou chamando de user e passando .to_hash

#       #agora quero garantir que essa massa será sempre valida
#       Database.new.delete_user(@new_user[:email]) #por ter colocado o método to_hash esta ação agora eh possivel

#       @result = HTTParty.post(
#       'http://127.0.0.1:3001/user',
#       body: @new_user.to_json,
#       headers: {
#         "Content-Type" => "application/json"
#       },
#       )
#     end

#     #Agora eu tenho uma expectativa isolada trabalhando com contexto
#     # it 'entao deve retornar 200' do
#     #   expect(@result.response.code).to eql '200'
#     # end

#     #o rspec permite escrever em uma linha
#     it{expect(@result.response.code).to eql '200'}
#   end
# end

# este codigo abaixo não tem o expect isolado dentro de um contexto
# describe 'cadastrar' do
#   it 'novo usuario' do
#     Database.new.delete_user('edi@tester.qa') #delete o usuario no banco antes de comecar

#     #Pegamos o resultado na variavel result
#     result = HTTParty.post(
#       'http://127.0.0.1:3001/user',
#       body: {
#         full_name: "Edi Tester",
#         email: "edi@tester.qa",
#         password: "12345"
#       }.to_json, #converte para .json o que eh hash
#       headers: {
#         "Content-Type" => "application/json"
#       },
#       )
#       puts result
#       expect(result.response.code).to eql '200'
#   end
# end
