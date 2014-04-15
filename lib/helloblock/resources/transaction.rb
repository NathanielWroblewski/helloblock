require 'helloblock/resources/query'
require 'helloblock/api_interface/api_parameters'

module HelloBlock
  class Transaction
    extend HelloBlock::Query
    include HelloBlock::APIParameters

    def self.propagate(raw_tx_hex)
      api_parameter = API_PARAMETERS[:propagate]
      query[:params][api_parameter] = raw_tx_hex
      query[:params][:post] = true
      self
    end

    # Class Method Alias
    self.singleton_class.send(:alias_method, :create, :propagate)
  end
end
