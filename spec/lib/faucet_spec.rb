require 'spec_helper'

describe HelloBlock::Faucet, '.where' do
  after :each do
    HelloBlock::Faucet.to_hash
  end

  it 'adds the type to the params' do
    HelloBlock::Faucet.where(type: 3)

    expect(HelloBlock::Faucet.query[:params]).to eq({ type: 3 })
    expect(HelloBlock::Faucet.query[:path]).to eq '/faucet'
  end
end

describe HelloBlock::Faucet, '.withdraw' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }
  after :each do
    HelloBlock::Faucet.to_hash
  end

  it 'adds the type to the params' do
    HelloBlock::Faucet.withdraw(to: address, amount: 100_000)

    expect(HelloBlock::Faucet.query[:path]).to eq '/faucet/withdrawal'
    expect(HelloBlock::Faucet.query[:params]).to eq(
      { toAddress: address, amount: 100_000, post: true }
    )
  end
end
