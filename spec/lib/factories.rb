# frozen_string_literal: true

require 'faker'
require_relative '../models/user_model' # descrito abaixo,
#ele vai sair dessa pasta e vai para a pasta spec e na pasta spec ele tera acesso a models e conseguira importar a user model

FactoryBot.define do
  
  factory :user, class: UserModel do
    full_name { 'Edi Tester' }
    email { 'edi@tester.qa' }
    password { '12345' }

    after(:build) do |user|
      Database.new.delete_user(user.email)
    end
  end

  factory :registered_user, class: UserModel do
    id { 0 } # comeca com 0 uma vez que nao temos um id e ele tambem eh usado no POST
    full_name { Faker::Movies::StarWars.character } # geracao de usuario dinamico
    email { Faker::Internet.free_email(name: full_name) } #ele vai gerar o email com base no nome do user
    password { '54321' }

    after(:build) do |user|
      Database.new.delete_user(user.email)
      result = ApiUser.save(user.to_hash) #eu vou garantir que o cara jah vai estar cadastrado la
      user.id = result.parsed_response['id'] #coloca aqui porque quando m user eh salvo, ele devolve o id
    end
  end

  factory :user_wrong_email, class: UserModel do
    full_name { 'Edi Tester' }
    email { 'email_invalido' }
    password { '12345' }
  end

  factory :user_empty_name, class: UserModel do
    full_name { '' }
    email { 'edi@tester.qa' }
    password { '12345' }
  end
  factory :user_empty_email, class: UserModel do
    full_name { 'Edi Tester' }
    email { '' }
    password { '12345' }
  end
  factory :user_empty_password, class: UserModel do
    full_name { 'Edi Tester' }
    email { 'edi@tester.qa' }
    password { '' }
  end
end


# factory :registered_user, class: UserModel do
#   id { 0 } # comeca com 0 uma vez que nao temos um id e ele tambem eh usado no POST
#   full_name { 'Edu Tester' } #eu preciso deixar essa criacao de usuario dinamica
#   email { 'edi@tester.qa' }
#   password { '54321' }

#   after(:build) do |user|
#     Database.new.delete_user(user.email)
#     result = ApiUser.save(user.to_hash) #eu vou garantir que o cara jah vai estar cadastrado la
#     user.id = result.parsed_response['id'] #coloca aqui porque quando m user eh salvo, ele devolve o id
#   end
# end

#require_relative 'models/user_model' # preciso importar o que esta dentro do diretorio models
# FactoryBot.define do
#   factory :user, class: UserModel do # estou criando uma fabrica de usuarios (user) a partir da classe UserModel
#     full_name { ' Edi Tester' }
#     email { 'edi@tester.qa' }
#     password { '12345' }

#     after(:build) do |user| #apos o buld pegue os dados do usuario
#       #puts 'Apagando o email: ' + user.email
#       Database.new.delete_user(user.email) #removido o hash pois esta em formato de factory
#     end
#   end
# end
# #sempre que eu precisar criar uma massa de user, eu posso acessar essa fabrica user