# Laundry [![Build Status](https://api.travis-ci.org/wilg/laundry.png?branch=master)](http://travis-ci.org/wilg/laundry) [![Coverage ](https://coveralls.herokuapp.com/repos/wilg/laundry/badge.png?branch=master)](https://travis-ci.org/wilg/laundry/) [![Code Climate](https://codeclimate.com/github/wilg/laundry.png)](https://codeclimate.com/github/wilg/laundry) [![Dependency Status](https://gemnasium.com/wilg/laundry.png)](https://gemnasium.com/wilg/laundry)

Have you ever wanted to use [ACH Direct](http://www.achdirect.com)'s [Payments
Gateway](http://www.paymentsgateway.com) SOAP API? Neither did anyone. However,
with this little gem you should be able to interact with it without going too
terribly nuts.

The goal is to have a lightweight ActiveRecord-ish syntax to making payments,
    updating client information, etc.

[View the Rdoc](http://rdoc.info/github/wilg/laundry/master/frames)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'laundry'
```

Laundry isn't compatible with ruby 1.9.3-p194, due to a bug in that specific release. ([More info](https://github.com/savonrb/nori/pull/24))

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install laundry

## Usage

### Merchant Setup

As a user of Payments Gateway's API, you probably have a *merchant account*,
   which serves as the context for all your transactions.

The first thing will be to **enter your api key details**:

```ruby
merchant = Laundry::PaymentsGateway::Merchant.new({
  id: '123456',
  api_login_id: 'abc123',
  api_password: 'secretsauce',
  transaction_password: 'moneymoneymoney'
})
```

### Sandbox

In development? You should probably **sandbox** this baby:

```ruby
Laundry.sandboxed = !Rails.env.production?
```

### The Good Stuff

Then you can **find a client**:

```ruby
client = merchant.clients.find(10)
```

Create a **bank account**:

```ruby
account_id = client.accounts.create!({
  acct_holder_name: user.name,
  ec_account_number: '12345678912345689',
  ec_account_trn: '123457890',
  ec_account_type: "CHECKING"
})
```

Or find an existing one:

```ruby
account = client.accounts.find(1234)
```

And, of course, **Send some money**:
```ruby
account.credit_cents 1250
```

Or take it:

```ruby
account.debit_cents 20000
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

allo
