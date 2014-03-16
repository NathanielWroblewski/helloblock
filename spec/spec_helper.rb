require 'helloblock'
require 'rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixture/vcr_cassettes'
  config.hook_into :webmock
end
