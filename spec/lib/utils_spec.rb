require 'spec_helper'

describe HelloBlock::Utils, '.mattr_accessor' do
  it 'sets accessors on a module' do
    module Test; extend HelloBlock::Utils; mattr_accessor :boom; end
    Test.boom = 'pop'

    expect(Test.boom).to eq 'pop'
  end
end
