require 'helloblock/utils'

module HelloBlock
  module Configuration

    extend HelloBlock::Utils
    mattr_accessor :api_key, :network, :version


    def network
      @network ||= :mainnet
    end

    def version
      @version ||= :v1
    end

    def configure
      yield self if block_given?
    end
  end
end
