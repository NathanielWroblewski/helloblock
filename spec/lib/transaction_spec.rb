require 'spec_helper'

describe HelloBlock::Transaction, '.query' do
  it 'defaults to the query hash' do
    expect(HelloBlock::Transaction.query).to eq(
      { path: '/transactions/', params: {} }
    )
  end
end

describe HelloBlock::Transaction, '.to_hash' do
  it 'kicks the query and resets the query hash' do
    HelloBlock::Transaction.find('bananas')

    HelloBlock::Transaction.to_hash

    expect(HelloBlock::Transaction.query).to eq(
      { path: '/transactions/', params: {} }
    )
  end
end

describe HelloBlock::Transaction, '.find' do
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }
  after :each do
    HelloBlock::Transaction.query.to_hash #clear the query for other specs
  end

  it 'adds a single transaction hash to the path' do
    HelloBlock::Transaction.find(tx)

    expect(HelloBlock::Transaction.query[:path]).to eq("/transactions/#{tx}")
  end
end

describe HelloBlock::Transaction, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }
  after :each do
    HelloBlock::Transaction.to_hash
  end

  it 'adds a batch of transaction hashes to the params and alters the path' do
    HelloBlock::Transaction.where(transaction: [tx, tx])

    expect(HelloBlock::Transaction.query[:params]).to eq(
      txHashes: [tx, tx]
    )
  end

  it 'adds a batch of addresses to the params' do
    HelloBlock::Transaction.where(address: [address, address])

    expect(HelloBlock::Transaction.query[:path]).to eq '/addresses/transactions'
    expect(HelloBlock::Transaction.query[:params]).to eq(
      { addresses: [address, address] }
    )
  end
end

#
# describe HelloBlock::Address, '.where' do
#   let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
#   let(:connection) { double(:faraday_connection).as_null_object }
#
#   it 'adds a batch of specific addresses to the params' do
#     HelloBlock.stub(:connection).and_return(connection)
#
#     HelloBlock::Address.where(address: [address, address]).to_hash
#
#     expect(connection).to have_received(:get).with(
#       '/v1/addresses/', { addresses: [address, address] },
#       { accept: '*/*', content_type: 'application/json; charset=UTF-8' }
#     )
#   end
# end
