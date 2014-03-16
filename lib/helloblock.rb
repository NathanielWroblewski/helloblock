require 'helloblock/version'
require 'helloblock/endpoints'
require 'helloblock/query'
require 'helloblock/address'
require 'helloblock/connection'
require 'helloblock/request'
require 'helloblock/configuration'
require 'helloblock/spec_helper'

module HelloBlock
  extend HelloBlock::Endpoints
  extend HelloBlock::Request
  extend HelloBlock::Connection
  extend HelloBlock::Configuration
  extend HelloBlock::SpecHelper
end
