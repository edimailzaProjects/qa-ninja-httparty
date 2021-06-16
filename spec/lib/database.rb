# frozen_string_literal: true

require 'pg'

class Database #database se encontra na biblioteca lib porque ela eh uma biblioteca feita para facilitar nossos testes
  def initialize #este é o construtor que inicializa a conexão com o bd
    conn = { host: '127.0.0.1', dbname: 'nflix', user: 'postgres', password: 'qaninja'}
    #agora, crie uma variavel de instancia
    @connection = PG.connect(conn) #esta variavel vai ser usada nas consultas
  end

  #para usar este comando, eu preciso ir em helpers criar um before generico
  def clean_database
    @connection.exec('DELETE FROM public.users where id > 1;') #este comando foi dado pois o user tony eh compartilhado e seu id eh 1
    #se este user '1' nao fosse compartilhado, o truncate seria mais que pertinente ou drop table
  end

  def delete_user(email)
    @connection.exec("DELETE from public.users where email = '#{email}';")
  end

  def find_user(email)
    query = "SELECT id, full_name, password, email, created_at, updated_at FROM public.users WHERE email = '#{email}';"
    @connection.exec(query).first #ele devolve um array com apenas a primeira posicao
  end
end
