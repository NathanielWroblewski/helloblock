# HelloBlock

[![Code Climate](https://codeclimate.com/github/NathanielWroblewski/helloblock.png)](https://codeclimate.com/github/NathanielWroblewski/helloblock)

Fluent ruby wrapper for the [HelloBlock](http://www.helloblock.io) API.  For a simple, non-fluent wrapper that avoids the Singleton pattern, see [helloblock-ruby](http://github.com/nathanielwroblewski/helloblock-ruby).

## Installation

Add this line to your application's Gemfile:

    gem 'helloblock'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install helloblock

## Usage

Configure your HelloBlock session:

```rb
HelloBlock.configure do |config|
  config.api_key = ENV['APIKEY'] # your api key goes here
  config.version = :v1           # defaults to latest version
  config.network = :mainnet      # defaults to testnet
end
```

Query the HelloBlock API with familiar [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord)-like syntax.  NOTE: As of the current version, `#to_hash` must be called on each completed query as a kicker method.

Description  | Method
------------- | ------------- |
Fetch a single address  | `HelloBlock::Address.find('1DQN9nop...')`|
Fetch batch addresses  | `HelloBlock::Address.where(addresses: ['1DQN9nop...', ...])` |
Fetch unspents for address  | `HelloBlock::Address.find('1DQN9nop...').unspents` |
Fetch unspents for addresses  | `HelloBlock::Address.unspents.where(addresses: ['1DQN9nop...', ...])` |
Fetch a single transaction  | `HelloBlock::Transaction.find('f37e6181...')` |
Fetch batch transactions  | `HelloBlock::Transaction.where(tx_hashes: ['f37e6181...', ...])` |
Fetch transactions by addresses  | `HelloBlock::Transaction.where(addresses: ['1DQN9nop...', ...])` |
Fetch latest transactions  | `HelloBlock::Transaction.limit(5).offset(7)` |
Propagate a transaction  | `HelloBlock::Transaction.propagate('01000...')` |
Fetch a block  | `HelloBlock::Block.find('00000...')` |
Fetch latest block  | `HelloBlock::Block.limit(1)` |
Fetch wallet information | `HelloBlock::Wallet.where(addresses: [...], unspents: false)` |
Fetch unspents from faucet | `HelloBlock::Faucet.where(type: 3)` |
Withdraw from faucet | `HelloBlock::Faucet.withdraw(to: '1DQN9nop...', amount: 100_000)` |

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
