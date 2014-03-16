require 'helloblock/endpoints'
require 'pry'

module HelloBlock
  module Request

    include HelloBlock::Endpoints

    def get(path, params={})
      request(:get, version_path + path, params, headers)
    end

    def post(path, params={})
      request(:post, version_path + path, { body: params }, headers)
    end

    private

    def request(method, path, params={}, headers={})
      # format_batches(params) if params
      binding.pry
      connection.send(method.to_sym, path, params, headers).body
    end

    def headers
      { accept: '*/*', content_type: 'application/json; charset=UTF-8' }
    end

    # def format_batches(params)
    #   params.each do |key, value|
    #     params[key] = value.join("&#{key}=") if value.is_a?(Array)
    #   end
    # end
  end
end
