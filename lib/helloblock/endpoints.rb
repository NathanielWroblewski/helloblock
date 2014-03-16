module HelloBlock
  module Endpoints
    ENDPOINTS = {
      address:     '/addresses/',
      transaction: '/transactions/',
      wallet:      '/wallet/',
      block:       '/blocks/',
      faucet:      '/faucet/'
    }

    def base_url
      "http://#{network}.helloblock.io"
    end

    def version_path
      "/#{version}"
    end
  end
end
