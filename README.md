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

You can also see a simplified Rack example in [bin/server](bin/server).

## Auth Hash

Here's an example Auth Hash available in `request.env['omniauth.auth']`:

```ruby
{
  provider: "eklase",
  uid: "99895d09-a454-4f46-9a26-35b4d038c6fe",
  info: {
    "id"                   => "99895d09-a454-4f46-9a26-35b4d038c6fe",
    "first_name"           => "Ivo",
    "last_name"            => "Paraugs",
    "person_type"          => "Student",
    "user_name"            => "skolens123456789",
    "school_id"            => "IDACC-ORG-20111012-BBBF04AC",
    "school"               => "Testa skola",
    "class_number"         => "8",
    "class_number_postfix" => "b",
    "class_alias"          => "8.b (PĢ)"
  },
  credentials: {
    "token"      => "99895d09-a454-4f46-9a26-35b4d038c6fe",
    "expires_at" => 1452258538,
    "expires"    => true
  },
  extra: {
    raw_info: {
      "Person" => {
        "ID"                 => "99895d09-a454-4f46-9a26-35b4d038c6fe",
        "FirstName"          => "Ivo",
        "LastName"           => "Paraugs",
        "PersonType"         => "Student",
        "UserName"           => "skolens123456789",
        "SchoolId"           => "IDACC-ORG-20111012-BBBF04AC",
        "School"             => "Testa skola",
        "ClassNumber"        => "8",
        "ClassNumberPostfix" => "b",
        "ClassAlias"         => "8.b (PĢ)"
      }
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
