require 'helloblock/resources/query'
require 'helloblock/api_interface/endpoints'

module HelloBlock
	class Address < HelloBlock::Query
		include HelloBlock::Endpoints

		class << self
			def unspents
				query = self.new
				query.unspents
			end
		end

		def unspents
			self.query[:path] += ENDPOINTS[:unspents]
			self.query[:path].squeeze!('/')
			self
		end

	end
end
