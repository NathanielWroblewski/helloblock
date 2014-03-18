require 'helloblock/query'
require 'helloblock/endpoints'
require 'helloblock/api_parameters'

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
