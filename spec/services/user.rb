# frozen_string_literal: true

class ApiUser
  include HTTParty
  base_uri 'http://127.0.0.1:3001'
  headers 'Content-Type' => 'application/json'

  def self.save(user)
    post('/user', body: user.to_json)
  end

  def self.find(token, user_id)
    get("/user/#{user_id}", headers: { 'Authorization' => token })
  end

  def self.token(user_email, user_pass) # pega o token quando se da o email
    result = post('/auth', body: { email: user_email, password: user_pass }.to_json)
    "JWT #{result.parsed_response['token']}"
  end

  def self.remove(token, user_id) #mesma estrutura do get, so que 'delete'
    delete("/user/#{user_id}", headers: { 'Authorization' => token })
  end

  # #este metodo fara o post do user usando HTTParty
  # def self.save(user)
  #   post('/user', body: user.to_json) #passa a rota user e recebe o objeto hash e ja converte pra .json
  #   #o self fara uso do metodo que fara uso da API User
  #   #com todos os recursos do HTTParty
  #   #agora basta importar no spec_helper a user.rb bem como seu diretorio
  # end
end
