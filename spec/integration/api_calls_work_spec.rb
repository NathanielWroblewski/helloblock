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
