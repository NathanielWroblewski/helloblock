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
      response = HelloBlock::Address.where(addresses: [address, address])

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
        addresses: [address, address]
      ).unspents

      expect(response['status']).to eq 'success'
    end
  end

  it 'retrieves from the API unspents for a batch of addresses regardless of placement' do
    VCR.use_cassette(:batch_unspents) do
      response = HelloBlock::Address.unspents.where(
        addresses: [address, address]
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
      response = HelloBlock::Transaction.where(tx_hashes: [tx, tx])

      expect(response['status']).to eq 'success'
    end
  end

  it 'retrieves from the API a batch of transactions given several addresses' do
    VCR.use_cassette(:batch_transactions_addresses) do
      response = HelloBlock::Transaction.where(addresses: [address, address])

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Transaction, '.limit' do
  it 'retrieves the latest transactions from the API' do
    VCR.use_cassette(:latest_transactions) do
      response = HelloBlock::Transaction.limit(5)

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

describe HelloBlock::Block, '.limit' do
  it 'retrieves the latest blocks from the API' do
    VCR.use_cassette(:latest_blocks) do
      response = HelloBlock::Block.limit(1)

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Wallet, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'retrieves wallet information from the API' do
    VCR.use_cassette(:wallet) do
      response = HelloBlock::Wallet.where(addresses: [address], unspents: false)

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

describe HelloBlock::Transaction, '.propagate' do
  let(:tx) { '0100000001dfcc651d60fae6f086fba5a6d2729cfea5cb867f4c1bca' +
             '25192fcb60823490d6000000006b483045022100a7a7194ca4329369' +
             '3249ccbe5bbb54efb17d22dcbfdd27c47fec1c6f2287553b02204eb7' +
             '873322565308b06cc8a9e43c68c987d5d7eec570b2e135625c0fbe4b' +
             '286101210355b6182f1d4ce3caad921d6abf37a20143c49f492ea606' +
             'e8f66d0d291b0d4ab3ffffffff0110270000000000001976a91439a9' +
             'becbf4c55b7346de80e307596901a3491c9c88ac00000000' }
  it 'posts a new transaction to be propagated to the API' do
    VCR.use_cassette(:propagate) do
      response = HelloBlock::Transaction.propagate(tx)

      expect(response['status']).to eq 'success'
    end
  end
end


describe HelloBlock::Faucet, '.withdraw' do
  let(:address) { 'mzPkw5EdvHCntC2hrhRXSqwHLHpLWzSZiL' }

  it 'posts a withdrawal to the API' do
    VCR.use_cassette(:withdrawal) do
      response = HelloBlock::Faucet.withdraw(to: address, value: 100_000)

      expect(response['status']).to eq 'success'
    end
  end
end


describe HelloBlock::RPC, '.where' do
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }

  it 'hits a temporary api endpoint for compatibility with bitcoin ruby' do
    VCR.use_cassette(:rpc) do
      response = HelloBlock::RPC.where(tx_hashes: [tx, tx])

      expect(response['status']).to eq 'success'
    end
  end
end
