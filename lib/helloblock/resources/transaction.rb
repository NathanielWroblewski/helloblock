require 'helloblock/resources/query'
require 'helloblock/api_interface/api_parameters'

module HelloBlock
  class Transaction < HelloBlock::Query
    extend HelloBlock::APIParameters

    class << self
      def propagate(raw_tx_hex)
        txQuery = self.new
        api_parameter = API_PARAMETERS[:propagate]
        txQuery.query[:params][api_parameter] = raw_tx_hex
        txQuery.query[:params][:post] = true
        txQuery
      end
    end

    # Class Method Alias
    self.singleton_class.send(:alias_method, :create, :propagate)
  end
end
