require 'helloblock/resources/query'
require 'helloblock/api_interface/endpoints'
require 'helloblock/api_interface/api_parameters'

module HelloBlock
  class Faucet < HelloBlock::Query

    def self.withdraw(conditions)
      faucetQuery = self.new
      faucetQuery.where(conditions.merge({post: true}))
      faucetQuery.query[:path] = ENDPOINTS[:withdraw]
      faucetQuery
    end
  end
end
