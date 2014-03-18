require 'helloblock/query'
require 'helloblock/endpoints'

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
