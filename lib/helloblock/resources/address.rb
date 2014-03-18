require 'helloblock/resources/query'
require 'helloblock/api_interface/endpoints'

module HelloBlock
  class Address
    extend HelloBlock::Query
    include HelloBlock::Endpoints

    def self.unspents
      query[:path] += ENDPOINTS[:unspents]
      query[:path].squeeze!('/')
      self
    end
  end
end
