# HelloBlock

Fluent ruby wrapper for the [HelloBlock](http://www.helloblock.io) API.  For a simple, non-fluent wrapper, see [helloblock-ruby](http://github.com/nathanielwroblewski/helloblock-ruby).

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
  config.api_key = 'APIKEY' # your api key goes here
  config.version = :v1      # defaults to latest version
  config.network = :mainnet # defaults to testnet
end
```

Query the HelloBlock API with familiar [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord)-like syntax.  NOTE: As of the current version, `#to_hash` must be called on each completed query as a kicker method.

Description  | Method
------------- | ------------- |
Fetch a single address  | `HelloBlock::Address.find('1DQN9nop...').to_hash`|
Fetch batch addresses  | `HelloBlock::Address.where(address: ['1DQN9nop...', ...]).to_hash` |
Fetch a single transaction  | `HelloBlock::Transaction.find('f37e6181...').to_hash` |
Fetch batch transactions  | `HelloBlock::Transaction.where(transaction: ['f37e6181...', ...]).to_hash` |

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
