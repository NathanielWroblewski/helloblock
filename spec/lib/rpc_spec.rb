require 'spec_helper'

describe HelloBlock::RPC, '.where' do
  let(:tx) { 'f37e6181661473c14a123cca6f0ad0ab3303d011246f1d4bb4ccf3fccef2d700' }
  before :each do
    HelloBlock::RPC.inspect
  end

  it 'uses a temporary api endpoint for bitcoin ruby compatibility' do
    HelloBlock::RPC.where(transaction: [tx, tx])

    expect(HelloBlock::RPC.query[:path]).to eq '/getrawtransaction'
    expect(HelloBlock::RPC.query[:params]).to eq({ txHashes: [tx, tx]})
  end
end
