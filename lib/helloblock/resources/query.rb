require 'helloblock/api_interface/endpoints'
require 'helloblock/api_interface/api_parameters'

module HelloBlock
  class Query
    attr_accessor :query, :executed, :result
    include HelloBlock::Endpoints
    include HelloBlock::APIParameters
    extend HelloBlock::APIParameters # Some class methods requrie this

    def initialize
      @query = { path: ENDPOINTS[parent_class], params: {} }
      @executed = false
      @result = {}
    end

    class << self
      def parent_class
        self.to_s.split('::').last.downcase.to_sym
      end

      def find(id)
        query = self.new
        query.find(id)
      end

      def where(conditions)
        query = self.new
        query.where(conditions)
      end

      def limit(limit)
        query = self.new
        query.limit(limit)
      end

      def offset(number)
        query = self.new
        query.offset(number)
      end

      alias_method :last, :limit
    end

    def parent_class
      self.class.to_s.split('::').last.downcase.to_sym
    end

    def find(id)
      self.query[:path] += id
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
      self.query[:path] = ENDPOINTS[parent_class] + ENDPOINTS[:latest]
      self.query[:params][:limit] = limit
      self
    end

    alias_method :last, :limit

    def offset(number)
      self.query[:params][:offset] = number
      self
    end

    def to_hash
      if self.executed == true
        return self.result
      end

      method = self.query[:params][:post] ? :post : :get
      self.executed = true
      self.result = HelloBlock.send(method, self.query[:path], self.query[:params])
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
      if self.query[:path] == ENDPOINTS[:transaction] && self.query[:params][:addresses]
        self.query[:path] = ENDPOINTS[:addresses_transactions]
      end
    end
  end
end
