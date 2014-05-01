require 'spec_helper'

describe HelloBlock::Transaction, '.find' do
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }

  it 'adds a single transaction hash to the path' do
    response = HelloBlock::Transaction.find(tx)

    expect(response.query[:path]).to eq("/transactions/#{tx}")
  end
end

describe HelloBlock::Transaction, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }

  it 'adds a batch of transaction hashes to the params and alters the path' do
    response = HelloBlock::Transaction.where(tx_hashes: [tx, tx])

    expect(response.query[:params]).to eq(
      txHashes: [tx, tx]
    )
  end

  it 'adds a batch of addresses to the params' do
    response = HelloBlock::Transaction.where(addresses: [address, address])

    expect(response.query[:path]).to eq '/addresses/transactions'
    expect(response.query[:params]).to eq(
      { addresses: [address, address] }
    )
  end
end


describe HelloBlock::Transaction, '.limit' do

  it 'changes the path to the latest transactions path and passes a limit' do
    response = HelloBlock::Transaction.limit(5)

    expect(response.query[:path]).to eq '/transactions/latest'
    expect(response.query[:params]).to eq({ limit: 5 })
  end
end

describe HelloBlock::Transaction, '.offset' do

  it 'changes the path to the latest transactions path and passes a limit' do
    response = HelloBlock::Transaction.offset(5)

    expect(response.query[:params]).to eq({ offset: 5 })
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

  it 'sets the raw transaction hex in the parameters' do
    response = HelloBlock::Transaction.propagate(tx)

    expect(response.query[:params]).to eq({ rawTxHex: tx, post: true })
  end
end
