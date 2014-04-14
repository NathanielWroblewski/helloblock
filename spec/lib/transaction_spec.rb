require 'spec_helper'

describe HelloBlock::Transaction, '.query' do
  it 'defaults to the query hash' do
    expect(HelloBlock::Transaction.query).to eq(
      { path: '/transactions/', params: {} }
    )
  end
end

describe HelloBlock::Transaction, 'inspect' do
  it 'kicks the query and resets the query hash' do
    HelloBlock::Transaction.find('bananas')

    HelloBlock::Transaction.inspect

    expect(HelloBlock::Transaction.query).to eq(
      { path: '/transactions/', params: {} }
    )
  end
end

describe HelloBlock::Transaction, '.find' do
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }
  after :each do
    HelloBlock::Transaction.inspect #clear the query for other specs
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
    HelloBlock::Transaction.inspect
  end

  it 'adds a batch of transaction hashes to the params and alters the path' do
    HelloBlock::Transaction.where(tx_hashes: [tx, tx])

    expect(HelloBlock::Transaction.query[:params]).to eq(
      txHashes: [tx, tx]
    )
  end

  it 'adds a batch of addresses to the params' do
    HelloBlock::Transaction.where(addresses: [address, address])

    expect(HelloBlock::Transaction.query[:path]).to eq '/addresses/transactions'
    expect(HelloBlock::Transaction.query[:params]).to eq(
      { addresses: [address, address] }
    )
  end
end


describe HelloBlock::Transaction, '.limit' do
  after :each do
    HelloBlock::Transaction.inspect
  end

  it 'changes the path to the latest transactions path and passes a limit' do
    HelloBlock::Transaction.limit(5)

    expect(HelloBlock::Transaction.query[:path]).to eq '/transactions/latest'
    expect(HelloBlock::Transaction.query[:params]).to eq({ limit: 5 })
  end
end

describe HelloBlock::Transaction, '.offset' do
  after :each do
    HelloBlock::Transaction.inspect
  end

  it 'changes the path to the latest transactions path and passes a limit' do
    HelloBlock::Transaction.offset(5)

    expect(HelloBlock::Transaction.query[:params]).to eq({ offset: 5 })
  end
end




describe HelloBlock::Transaction, '.propagate' do
  let(:tx) { '0100000001dfcc651d60fae6f086fba5a6d2729cfea5cb867f4c1bca' +
             '25192fcb60823490d6000000006b483045022100a7a7194ca4329369' +
             '3249ccbe5bbb54efb17d22dcbfdd27c47fec1c6f2287553b02204eb7' +
             '873322565308b06cc8a9e43c68c987d5d7eec570b2e135625c0fbe4b' +
             '286101210355b6182f1d4ce3caad921d6abf37a20143c49f492ea606' +
             'e8f66d0d291b0d4ab3ffffffff0110270000000000001976a91439a9' +
             'becbf4c55b7346de80e307596901a3491c9c88ac00000000' }
  after :each do
    HelloBlock::Transaction.inspect
  end

  it 'sets the raw transaction hex in the parameters' do
    HelloBlock::Transaction.propagate(tx)

    expect(HelloBlock::Transaction.query[:params]).to eq({ rawTxHex: tx, post: true })
  end
end
