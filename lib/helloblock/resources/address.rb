require 'helloblock/resources/query'
require 'helloblock/api_interface/endpoints'

module HelloBlock
	class Address < HelloBlock::Query
		include HelloBlock::Endpoints
		extend HelloBlock::Endpoints

		class << self
			def unspents
				addressQuery = self.new
				addressQuery.query[:path] += ENDPOINTS[:unspents]
				addressQuery.query[:path].squeeze!('/')
				addressQuery
			end
		end

		def unspents
			self.query[:path] += ENDPOINTS[:unspents]
			self.query[:path].squeeze!('/')
			self
		end

	end
end
