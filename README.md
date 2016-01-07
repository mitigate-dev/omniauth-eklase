# OmniAuth e-klase.lv

[![Continuous Integration status](https://secure.travis-ci.org/mak-it/omniauth-eklase.svg)](http://travis-ci.org/mak-it/omniauth-eklase)

OmniAuth strategy for authenticating to [e-klase.lv](https://www.e-klase.lv/).

## Installation

Add to your `Gemfile`:

```ruby
gem 'omniauth-eklase'
```

## Usage

Here's a quick example, adding the middleware to a Rails app
in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eklase, "CLIENT_ID", "CLIENT_SECRET"
end
```

## Auth Hash

Here's an example Auth Hash available in `request.env['omniauth.auth']`:

```ruby
{
  provider: "eklase",
  uid: "...",
  info: {
  },
  credentials: {
  },
  extra: {
    raw_info: {
    }
  }
}
```

## Contributing

1. Fork it ( https://github.com/mak-it/omniauth-eklase/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
