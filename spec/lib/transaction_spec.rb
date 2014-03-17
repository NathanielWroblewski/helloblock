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


describe HelloBlock::Transaction, '.last' do
  after :each do
    HelloBlock::Transaction.to_hash
  end

  it 'changes the path to the latest transactions path and passes a limit' do
    HelloBlock::Transaction.last(5)

    expect(HelloBlock::Transaction.query[:path]).to eq '/transactions/latest'
    expect(HelloBlock::Transaction.query[:params]).to eq({ limit: 5 })
  end
end

describe HelloBlock::Transaction, '.offset' do
  after :each do
    HelloBlock::Transaction.to_hash
  end

  it 'changes the path to the latest transactions path and passes a limit' do
    HelloBlock::Transaction.offset(5)

    expect(HelloBlock::Transaction.query[:params]).to eq({ offset: 5 })
  end
end
