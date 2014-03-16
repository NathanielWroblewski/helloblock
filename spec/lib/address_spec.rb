require 'spec_helper'

describe HelloBlock::Address, '.query' do
  it 'defaults to the query hash' do
    expect(HelloBlock::Address.query).to eq(
      { path: '/addresses/', params: {} }
    )
  end
end

describe HelloBlock::Address, '.find' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  after :each do
    HelloBlock::Address.query.to_hash # clear the query for other specs
  end

  it 'adds a single specific address to the path' do
    HelloBlock::Address.find(address)

    expect(HelloBlock::Address.query).to eq(
      { path: "/addresses/#{address}", params: {} }
    )
  end
end

describe HelloBlock::Address, '.to_hash' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  before :each do
    HelloBlock.stub(:get)
  end

  it 'resets the query' do
    HelloBlock::Address.find(address).to_hash

    expect(HelloBlock::Address.query).to eq({ path: "/addresses/", params: {} })
  end
end

describe HelloBlock::Address, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  let(:connection) { double(:faraday_connection).as_null_object }

  it 'adds a batch of specific addresses to the params' do
    HelloBlock.stub(:connection).and_return(connection)

    HelloBlock::Address.where(address: [address, address]).to_hash

    expect(connection).to have_received(:get).with(
      '/v1/addresses/', { addresses: "#{address}&addresses=#{address}" },
      { accept: '*/*', content_type: 'application/json; charset=UTF-8' }
    )
  end
end
