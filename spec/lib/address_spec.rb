require 'spec_helper'

describe HelloBlock::Address, '.query' do
  it 'defaults to the query hash' do
    expect(HelloBlock::Address.query).to eq(
      { path: '/addresses/', params: {} }
    )
  end
end

describe HelloBlock::Address, '.find' do
  let(:address) { '1DQN9nopGvSCDnM3LH1w7j36FtnQDZKnej' }

  it 'adds a single specific address to the path' do
    HelloBlock::Address.find(address)

    expect(HelloBlock::Address.query).to eq(
      { path: "/addresses/#{address}", params: {} }
    )
  end
end
