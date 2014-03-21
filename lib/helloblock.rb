require 'helloblock/version'
require 'helloblock/api_interface/endpoints'
require 'helloblock/resources/query'
require 'helloblock/resources/address'
require 'helloblock/resources/transaction'
require 'helloblock/resources/block'
require 'helloblock/resources/wallet'
require 'helloblock/resources/faucet'
require 'helloblock/resources/rpc'
require 'helloblock/http/connection'
require 'helloblock/http/request'
require 'helloblock/configuration'
require 'helloblock/spec_helper'

module HelloBlock
  extend HelloBlock::Endpoints
  extend HelloBlock::Request
  extend HelloBlock::Connection
  extend HelloBlock::Configuration
  extend HelloBlock::SpecHelper
end
