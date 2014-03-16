require 'spec_helper'

describe HelloBlock::Request, '.get' do
  let(:connection) { double(:faraday_connection).as_null_object }
  before :each do
    HelloBlock.stub(:connection).and_return(connection)
  end

  it 'is available on HelloBlock' do
    connection.stub_chain(:get, :body)

    HelloBlock.get('/bananas/', {})

    expect(connection).to have_received(:get).with(
      '/v1/bananas/', {}, {
          accept: '*/*',
          content_type: 'application/json; charset=UTF-8'
        }
    )
  end
end

describe HelloBlock::Request, '.post' do
  let(:connection) { double(:faraday_connection).as_null_object }
  before :each do
    HelloBlock.stub(:connection).and_return(connection)
  end

  it 'is available on HelloBlock' do
    connection.stub_chain(:post, :body)

    HelloBlock.post('/bananas/', {})

    expect(connection).to have_received(:post).with(
      '/v1/bananas/', { body: {} }, {
          accept: '*/*',
          content_type: 'application/json; charset=UTF-8'
        }
    )
  end
end
