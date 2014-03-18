require 'helloblock/resources/query'
require 'helloblock/api_interface/endpoints'
require 'helloblock/api_interface/api_parameters'

module HelloBlock
  class Faucet
    extend HelloBlock::Query
    include HelloBlock::Endpoints
    include HelloBlock::APIParameters

    def self.withdraw(conditions)
      where(conditions.merge({post: true}))
      query[:path] = ENDPOINTS[:withdraw]
      self
    end
  end
end
