require 'helloblock/query'
require 'helloblock/api_parameters'

module HelloBlock
  class Transaction
    extend HelloBlock::Query
    include HelloBlock::APIParameters

    def self.create(raw_tx_hex)
      api_parameter = API_PARAMETERS[:propagate]
      query[:params][api_parameter] = raw_tx_hex
      self
    end
  end
end
