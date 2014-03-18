require 'helloblock/api_interface/endpoints'

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
      connection.send(method.to_sym, path, params, headers).body
    end

    def headers
      { accept: '*/*', content_type: 'application/json; charset=UTF-8' }
    end
  end
end
