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
    HelloBlock::Address.inspect # clear the query for other specs
  end

  it 'adds a single specific address to the path' do
    HelloBlock::Address.find(address)

    expect(HelloBlock::Address.query).to eq(
      { path: "/addresses/#{address}", params: {} }
    )
  end
end

describe HelloBlock::Address, 'inspect' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  before :each do
    HelloBlock.stub(:get)
  end

  it 'resets the query' do
    HelloBlock::Address.find(address).inspect

    expect(HelloBlock::Address.query).to eq({ path: "/addresses/", params: {} })
  end
end

describe HelloBlock::Address, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  let(:connection) { double(:faraday_connection).as_null_object }

  it 'adds a batch of specific addresses to the params' do
    HelloBlock.stub(:connection).and_return(connection)

    response = HelloBlock::Address.where(addresses: [address, address])

    response['status'] # kick the query

    expect(connection).to have_received(:get).with(
      '/v1/addresses/', { addresses: [address, address] },
      { accept: '*/*', content_type: 'application/json; charset=UTF-8' }
    )
  end
end

describe HelloBlock::Address, '.unspents' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  after :each do
    HelloBlock::Address.inspect
  end

  it 'adds the unspents endpoint to the path for a single address' do
    HelloBlock::Address.find(address).unspents

    expect(HelloBlock::Address.query[:path]).to eq "/addresses/#{address}/unspents"
  end

  it 'adds the unspents endpoint to the path for a batch of addresses' do
    HelloBlock::Address.where(addresses: [address, address]).unspents

    expect(HelloBlock::Address.query[:path]).to eq "/addresses/unspents"
    expect(HelloBlock::Address.query[:params]).to eq(
      { addresses: [address, address] }
    )
  end
end
