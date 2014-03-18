require 'spec_helper'

describe HelloBlock::Address, '.find' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'retrieves a single address from the API' do
    VCR.use_cassette(:single_address) do
      response = HelloBlock::Address.find(address)

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Address, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'retrieves batch addresses from the API' do
    VCR.use_cassette(:batch_addresses) do
      response = HelloBlock::Address.where(address: [address, address])

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Address, '.unspents' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'retrieves from the API unspents for a single address' do
    VCR.use_cassette(:single_address_unspents) do
      response = HelloBlock::Address.find(address).unspents

      expect(response['status']).to eq 'success'
    end
  end

  it 'retrieves from the API unspents for a batch of addresses' do
    VCR.use_cassette(:batch_address_unspents) do
      response = HelloBlock::Address.where(
        address: [address, address]
      ).unspents

      expect(response['status']).to eq 'success'
    end
  end

  it 'retrieves from the API unspents for a batch of addresses regardless of placement' do
    VCR.use_cassette(:batch_unspents) do
      response = HelloBlock::Address.unspents.where(
        address: [address, address]
      )

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Transaction, '.find' do
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }

  it 'retrieves a single transaction from the API' do
    VCR.use_cassette(:single_transaction) do
      response = HelloBlock::Transaction.find(tx)

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Transaction, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }

  it 'retrieves a batch of transactions from the API' do
    VCR.use_cassette(:batch_transactions) do
      response = HelloBlock::Transaction.where(transaction: [tx, tx])

      expect(response['status']).to eq 'success'
    end
  end

  it 'retrieves from the API a batch of transactions given several addresses' do
    VCR.use_cassette(:batch_transactions_addresses) do
      response = HelloBlock::Transaction.where(address: [address, address])

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Transaction, '.last' do
  it 'retrieves the latest transactions from the API' do
    VCR.use_cassette(:latest_transactions) do
      response = HelloBlock::Transaction.last(5)

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Block, '.find' do
  let(:block) { '00000000b873e79784647a6c82962c70d228557d24a747ea4d1b8bbe878e1206' }

  it 'retrieves a block from the API' do
    VCR.use_cassette(:single_block) do
      response = HelloBlock::Block.find(block)

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Block, '.last' do
  it 'retrieves the latest blocks from the API' do
    VCR.use_cassette(:latest_blocks) do
      response = HelloBlock::Block.last(1)

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Wallet, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'retrieves wallet information from the API' do
    VCR.use_cassette(:wallet) do
      response = HelloBlock::Wallet.where(address: [address], unspents: false)

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Faucet, '.where' do
  it 'retrieves unspents from the API faucet' do
    VCR.use_cassette(:faucet) do
      response = HelloBlock::Faucet.where(type: 3)

      expect(response['status']).to eq 'success'
    end
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
  it 'posts a new transaction to be propagated to the API' do
    VCR.use_cassette(:propagate) do
      response = HelloBlock::Transaction.create(tx)

      expect(response['status']).to eq 'success'
    end
  end
end


describe HelloBlock::Faucet, '.withdraw' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'posts a withdrawal to the API' do
    VCR.use_cassette(:withdrawal) do
      response = HelloBlock::Faucet.withdraw(to: address, amount: 100_000)

      expect(response['status']).to eq 'success'
    end
  end
end
