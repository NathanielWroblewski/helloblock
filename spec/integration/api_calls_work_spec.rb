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
  let(:tx) { '5faa6474c250fd6294aec220f082363327b0299802f681f50bfa598feef983f6' }

  it 'retrieves a single transaction from the API' do
    VCR.use_cassette(:single_transaction) do
      response = HelloBlock::Transaction.find(tx)

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Transaction, '.where' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  let(:tx) { '5faa6474c250fd6294aec220f082363327b0299802f681f50bfa598feef983f6' }

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

  it 'retrieves the latest transactions using alias_method :last' do
    VCR.use_cassette(:latest_transactions) do
      response = HelloBlock::Transaction.last(5)

      expect(response['status']).to eq 'success'
    end
  end
end

describe HelloBlock::Block, '.find' do
  let(:block) { '000000009b7262315dbf071787ad3656097b892abffd1f95a1a022f896f533fc' }

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

describe HelloBlock, 'testnet' do
  before :each do
    HelloBlock.network = :testnet
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
    let(:tx) { '010000000195de226422f1110e7253739241f'+
               'f1d2612623eac21999c4224d85d757d170ed1'+
               '010000008c493046022100f217843f5b5341a'+
               '430ad4314d7bc4e15cc384835ebe0085df223'+
               'cb8c57be1b2b022100e430f2969d83c07efa2'+
               '62f40ff955748212e9a5c596e3aecc6f54238'+
               '19276a050141040cfa3dfb357bdff37c8748c'+
               '7771e173453da5d7caa32972ab2f5c888fff5'+
               'bbaeb5fc812b473bf808206930fade81ef4e3'+
               '73e60039886b51022ce68902d96ef70ffffff'+
               'ff0210270000000000001976a914f3d5b0848'+
               '2c92ce43dcf90befa2a1cf17de9e46988ac58'+
               'a41a1f010000001976a91461b469ada61f37c'+
               '620010912a9d5d56646015f1688ac00000000' }

     it 'posts a new transaction to be propagated to the API' do
      VCR.use_cassette(:propagate) do
        response = HelloBlock::Transaction.propagate(tx)

        expect(response['status']).to eq 'success'
      end
    end

    it 'propagates using alias_method :create' do
      VCR.use_cassette(:propagate) do
        response = HelloBlock::Transaction.create(tx)

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


end
