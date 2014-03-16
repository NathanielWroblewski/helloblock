require 'spec_helper'

describe HelloBlock::Connection, '.connection' do
  it 'is available on HelloBlock' do
    faraday = double(:faraday_connection).as_null_object
    Faraday.stub(:new).and_return(faraday)

    connection = HelloBlock.connection

    expect(connection).to eq faraday
  end
end

describe HelloBlock::Connection, '.connection_options' do
  it 'returns the headers and request settings' do
    expect(HelloBlock.connection_options).to eq(
      { headers: {
          accept: 'application/json',
          user_agent: "HelloBlock Gem #{HelloBlock::VERSION}"
        },
        request: {
          open_timeout: 10,
          timeout: 30
        }
      }
    )
  end
end
