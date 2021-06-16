# frozen_string_literal: true

#eu vou criar esta classe UserModel que é o moedelo de dados do meu user
#ela tera os mesmos atributos utilizados no envio full_name, email, etc

class UserModel
  attr_accessor :id, :full_name, :email, :password #se coloco 0 no factory, aqui tambem deve ter
  #lembtando que o id eh usado no get, logo o to_hash nao deve ter o id para salvar

  #quando o factory criar o objeto passado na classe UserModel, ele sera convertido
  def to_hash #este metodo eh para converter o objeto Factory para hash
    {
      full_name: @full_name, #essa conversão me possibilita acessar a propriedade
      email: @email,
      password: @password
    }
  end
end
