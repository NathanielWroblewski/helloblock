require 'spec_helper'

describe HelloBlock::Transaction, '.query' do
  it 'defaults to the query hash' do
    expect(HelloBlock::Transaction.query).to eq(
      { path: '/transactions/', params: {} }
    )
  end
end
