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
    HelloBlock::Transaction.inspect
  end

  it 'changes the path to the latest transactions path and passes a limit' do
    HelloBlock::Transaction.last(5)

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

describe HelloBlock::Transaction, '.create' do
  let(:tx) { '0100000001ec71e2ceac8476bea21fbc4a97062c000f07def6c8ef8d917' +
             '1fb1a5e113418e0010000008c493046022100e6f39b4393794ef03b0f9d' +
             'c71395e0835a211015b42ab4329cb6a6c1c8b3c6ea022100f1ccae451f3' +
             '5e5c5ad25a8f7e7b5e778bafc4dc69dd560fab1cbadbb88767916014104' +
             'e1934263e84e202ebffca95246b63c18c07cd369c4f02de76dbd1db89e6' +
             '255dacb3ab1895af0422e24e1d1099e80f01b899cfcdf9b947575352dbc' +
             '1af57466b5ffffffff0210270000000000001976a914652c453e3f8768d' +
             '6d6e1f2985cb8939db91a4e0588ace065f81f000000001976a914cf0dfe' +
             '6e0fa6ea5dda32c58ff699071b672e1faf88ac00000000' }
  after :each do
    HelloBlock::Transaction.inspect
  end

  it 'sets the raw transaction hex in the parameters' do
    HelloBlock::Transaction.create(tx)

    expect(HelloBlock::Transaction.query[:params]).to eq({ rawTxHex: tx })
  end
end
