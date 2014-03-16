require 'helloblock/version'
require 'helloblock/utils'
require 'helloblock/endpoints'
require 'helloblock/query'
require 'helloblock/address'

module HelloBlock
  extend HelloBlock::Utils

  mattr_accessor :api_key, :network, :version

  class << self
    def network
      @@network ||= :testnet
    end

    def version
      @@version ||= :v1
    end

    def configure
      yield self if block_given?
    end

    def reset
      @@api_key = nil
      @@network = nil
      @@version = nil
    end
  end
end
