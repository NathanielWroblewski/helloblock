require 'spec_helper'

describe HelloBlock::Address, '.query' do
  it 'defaults to the query hash' do
    expect(HelloBlock::Address.query).to eq(
      { path: '/addresses/', params: {} }
    )
  end
end
