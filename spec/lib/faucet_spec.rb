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
