module HelloBlock
  module Request
    def get(path, params={})
      request(:get, path, params, headers)
    end

    def post(path, params={})
      request(:post, path, { body: params }, headers)
    end

    private

    def request(method, path, params={}, headers={})
      format_batches(params) if params
      connection.send(method.to_sym, path, params, headers).body
    end

    def headers
      { accept: '*/*', content_type: 'application/json; charset=UTF-8' }
    end

    def format_batches(params)
      params.each do |key, value|
        params[key] = value.join("&#{key}=") if value.is_a?(Array)
      end
    end
  end
end
