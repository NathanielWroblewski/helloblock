require 'pry'
require 'helloblock/endpoints'

module HelloBlock
  module Query
    include HelloBlock::Endpoints

    def query
      @@query ||= default_query
    end

    def default_query
      { path: ENDPOINTS[parent_class], params: {} }
    end

    def parent_class
      self.to_s.split('::').last.downcase.to_sym
    end

    def find(id)
      query[:path] += id
      self
    end

    def to_hash
      (query_copy = query.clone) and (@@query = default_query)
      if query_copy[:post]
        HelloBlock.post(query_copy[:path], query_copy[:params])
      else
        HelloBlock.get(query_copy[:path], query_copy[:params])
      end
    end
  end
end
