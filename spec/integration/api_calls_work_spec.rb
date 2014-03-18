require 'spec_helper'

describe HelloBlock::Address, '.find' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'retrieves a single address from the API' do
    VCR.use_cassette(:single_address) do
      response = HelloBlock::Address.find(address).to_hash

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Address, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'retrieves batch addresses from the API' do
    VCR.use_cassette(:batch_addresses) do
      response = HelloBlock::Address.where(address: [address, address]).to_hash

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Address, '.unspents' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'retrieves from the API unspents for a single address' do
    VCR.use_cassette(:single_address_unspents) do
      response = HelloBlock::Address.find(address).unspents.to_hash

      expect(response['status']).to eq 'success'
    end
  end

  it 'retrieves from the API unspents for a batch of addresses' do
    VCR.use_cassette(:batch_address_unspents) do
      response = HelloBlock::Address.where(
        address: [address, address]
      ).unspents.to_hash

      expect(response['status']).to eq 'success'
    end
  end

  it 'retrieves from the API unspents for a batch of addresses regardless of placement' do
    VCR.use_cassette(:batch_unspents) do
      response = HelloBlock::Address.unspents.where(
        address: [address, address]
      ).to_hash

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Transaction, '.find' do
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }

  it 'retrieves a single transaction from the API' do
    VCR.use_cassette(:single_transaction) do
      response = HelloBlock::Transaction.find(tx).to_hash

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Transaction, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }

  it 'retrieves a batch of transactions from the API' do
    VCR.use_cassette(:batch_transactions) do
      response = HelloBlock::Transaction.where(transaction: [tx, tx]).to_hash

      expect(response['status']).to eq 'success'
    end
  end

  it 'retrieves from the API a batch of transactions given several addresses' do
    VCR.use_cassette(:batch_transactions_addresses) do
      response = HelloBlock::Transaction.where(address: [address, address]).to_hash

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Transaction, '.last' do
  it 'retrieves the latest transactions from the API' do
    VCR.use_cassette(:latest_transactions) do
      response = HelloBlock::Transaction.last(5).to_hash

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Block, '.find' do
  let(:block) { '00000000b873e79784647a6c82962c70d228557d24a747ea4d1b8bbe878e1206' }

  it 'retrieves a block from the API' do
    VCR.use_cassette(:single_block) do
      response = HelloBlock::Block.find(block).to_hash

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Block, '.last' do
  it 'retrieves the latest blocks from the API' do
    VCR.use_cassette(:latest_blocks) do
      response = HelloBlock::Block.last(1).to_hash

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Wallet, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'retrieves wallet information from the API' do
    VCR.use_cassette(:wallet) do
      response = HelloBlock::Wallet.where(address: [address], unspents: false).to_hash

      expect(response['status']).to eq 'success'
    end
  end
end
