module HelloBlock
  module Endpoints
    ENDPOINTS = {
      address:                '/addresses/',
      addresses_transactions: '/addresses/transactions',
      unspents:               '/unspents',
      transaction:            '/transactions/',
      latest:                 'latest',
      wallet:                 '/wallet',
      block:                  '/blocks/',
      faucet:                 '/faucet',
      withdraw:               '/faucet/withdrawal'
    }

    def base_url
      "http://#{network}.helloblock.io"
    end

    def version_path
      "/#{version}"
    end
  end
end
