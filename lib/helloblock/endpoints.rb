module HelloBlock
  module Endpoints
    ENDPOINTS = {
      address:     '/addresses/',
      transaction: '/transactions/',
      wallet:      '/wallet/',
      block:       '/blocks/',
      faucet:      '/faucet/'
    }

    POST_REQUESTS = [:propagate, :withdraw]

    def base_url
      "http://#{network}.helloblock.io"
    end

    def version_path
      "/#{version}"
    end
  end
end
