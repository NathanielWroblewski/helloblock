require 'helloblock/api_interface/endpoints'
require 'helloblock/api_interface/api_parameters'

module HelloBlock
  module Query
    include HelloBlock::Endpoints
    include HelloBlock::APIParameters

    def query
      @query ||= default_query
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

    # where(tx_hashes: [...]) => converts :transaction to API's :txHashes
    def where(conditions)
      conditions.each do |resource, ids|
        api_resource = API_PARAMETERS[resource] || resource
        query[:params][api_resource] = ids
      end
      determine_parent_resource
      self
    end

    def limit(limit)
      query[:path] = ENDPOINTS[parent_class] + ENDPOINTS[:latest]
      query[:params][:limit] = limit
      self
    end

    alias_method :last, :limit

    def offset(number)
      query[:params][:offset] = number
      self
    end

    def to_hash
      (query_copy = query.clone) and (@query = default_query)
      method = query_copy[:params][:post] ? :post : :get
      query_copy[:params].delete(:post)
      HelloBlock.send(method, query_copy[:path], query_copy[:params])
    end

    def [](attribute)
      to_hash[attribute]
    end

    def []=(attribute, value)
      to_hash[attribute] = value
    end

    def inspect
      to_hash.to_s
    end

    # exceptions: querying transactions with addresses actually hits
    # /addresses/transactions endpoint
    def determine_parent_resource
      if query[:path] == ENDPOINTS[:transaction] && query[:params][:addresses]
        query[:path] = ENDPOINTS[:addresses_transactions]
      end
    end
  end
end
