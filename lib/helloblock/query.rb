require 'helloblock/endpoints'
require 'helloblock/api_parameters'

module HelloBlock
  module Query
    include HelloBlock::Endpoints
    include HelloBlock::APIParameters

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

    # where(transaction: [...]) => converts :transaction to API's :txHashes
    def where(conditions)
      conditions.each do |resource, ids|
        api_resource = API_PARAMETERS[resource]
        query[:params][api_resource] = ids
      end
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
