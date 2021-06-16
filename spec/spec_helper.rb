# frozen_string_literal: true

require 'httparty'
require 'factory_bot' #uso isso pra gerar massa de testes em vez de usar .csv ou .yaml

require_relative 'services/user' #implemente a camada de servico
require_relative 'lib/factories' # require_relative eh como o import do java so que de classes criadas por mim
require_relative 'lib/database' # eh preciso importar uma vez que vai acessar o banco

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryBot::Syntax::Methods  #configure o factory bot aqui

  config.before :all do #antes de executar todos os expects, eu vou executar este codigo
    Database.new.clean_database #eh importante limpar o banco antes em vez de depois, porque assim eh possivel manter um historico da ultima execuvcao
  end
end
