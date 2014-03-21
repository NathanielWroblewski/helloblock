require 'helloblock/resources/query'
require 'helloblock/api_interface/endpoints'

# this is a temporary class that exists for compatibility with bitcoin-ruby

module HelloBlock
  class RPC
    extend HelloBlock::Query
    include HelloBlock::Endpoints
  end
end
