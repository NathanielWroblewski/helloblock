require 'spec_helper'

describe HelloBlock::Faucet, '.where' do

  it 'adds the type to the params' do
    response = HelloBlock::Faucet.where(type: 3)

    expect(response.query[:params]).to eq({ type: 3 })
    expect(response.query[:path]).to eq '/faucet'
  end
end

describe HelloBlock::Faucet, '.withdraw' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'adds the type to the params' do
    response = HelloBlock::Faucet.withdraw(to: address, value: 100_000)

    expect(response.query[:path]).to eq '/faucet/withdrawal'
    expect(response.query[:params]).to eq(
      { toAddress: address, value: 100_000, post: true }
    )
  end
end
