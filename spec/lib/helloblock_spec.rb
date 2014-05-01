require 'spec_helper'

describe HelloBlock, '.api_key=' do
  it 'sets the api key' do
    HelloBlock.api_key = 'apikey'

    expect(HelloBlock.api_key).to eq 'apikey'
  end
end

describe HelloBlock, '.network=' do
  it 'sets the network to testnet or mainnet' do
    HelloBlock.network = :testnet

    expect(HelloBlock.network).to eq :testnet
  end
end

describe HelloBlock, '.network' do
  it 'defaults to mainnet' do
    expect(HelloBlock.network).to eq :mainnet
  end
end

describe HelloBlock, '.version=' do
  it 'sets the version of the api to use' do
    HelloBlock.version = :v5

    expect(HelloBlock.version).to eq :v5
  end
end

describe HelloBlock, '.version' do
  it 'defaults to v1' do
    expect(HelloBlock.version).to eq :v1
  end
end

describe HelloBlock, '.configure' do
  it 'accepts a block of configurations' do
    HelloBlock.configure do |config|
      config.api_key = 'bananas'
      config.network = :mainnet
      config.version = :v2
    end

    expect(HelloBlock.api_key).to eq 'bananas'
    expect(HelloBlock.network).to eq :mainnet
    expect(HelloBlock.version).to eq :v2
  end
end
