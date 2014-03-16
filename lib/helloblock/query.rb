require 'pry'
require 'helloblock/endpoints'

module HelloBlock
  module Query
    include HelloBlock::Endpoints

    def query
      @@query ||= { path: ENDPOINTS[parent_class], params: {} }
    end

    def parent_class
      self.to_s.split('::').last.downcase.to_sym
    end
  end
end
