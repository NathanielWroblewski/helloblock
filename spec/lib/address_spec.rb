require 'spec_helper'

describe HelloBlock::Address, '.find' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'adds a single specific address to the path' do
    response = HelloBlock::Address.find(address)

    expect(response.query).to eq(
      { path: "/addresses/#{address}", params: {} }
    )
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
    response = HelloBlock::Address.find(address).unspents

    expect(response.query[:path]).to eq "/addresses/#{address}/unspents"
  end

  it 'adds the unspents endpoint to the path for a batch of addresses' do
    response = HelloBlock::Address.where(addresses: [address, address]).unspents

    expect(response.query[:path]).to eq "/addresses/unspents"
    expect(response.query[:params]).to eq({ addresses: [address, address] }
    )
  end
end
