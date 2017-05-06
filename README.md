# OmniAuth for Burner
[![Build Status](https://travis-ci.org/berk/omniauth-surveymonkey2.png?branch=master)](https://travis-ci.org/berk/omniauth-surveymonkey2)
[![Coverage Status](https://coveralls.io/repos/berk/omniauth-surveymonkey2/badge.png?branch=master)](https://coveralls.io/r/berk/omniauth-surveymonkey2?branch=master)
[![Gem Version](https://badge.fury.io/rb/omniauth-surveymonkey2.svg)](http://badge.fury.io/rb/omniauth-surveymonkey2)

SurveyMonkey OAuth2 Strategy for OmniAuth 1.0.

Supports the OAuth 2.0 server-side. Read the SurveyMonkey docs for more details: 

https://developer.surveymonkey.com/api/v3/#authentication

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-surveymonkey2'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::SurveyMonkey` is simply a Rack middleware. Read the OmniAuth 1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :surveymonkey, ENV['SURVEYMONKEY_CLIENT_ID'], ENV['SURVEYMONKEY_SECRET']
end
```

## Authentication Hash

Here's an example *Authentication Hash* available in `request.env['omniauth.auth']`:

```ruby

{"provider"=>"burner",
 "uid"=>nil,
 "info"=> {
    "id" => "123",
    "username" => "test-user",
    "first_name" => "John",
    "last_name" => "Doe",
    "language" => "en",
    "email" => "test@surveymonkey.com",
    "account_type" => "enterprise_platinum",
    "date_created" => "2015-10-06T12:56:55+00:00",
    "date_last_login" => "2015-10-06T12:560000:55+00:00"
 },
 "credentials"=> {
    "token"=> "dfkjadlfkjasdkjflaskdjfjsldflasjdflkasdjflaskdjf",
    "expires_at"=>1489053154,
    "expires"=>true
 },
 "extra"=>{}}
 
```

The precise information available may depend on the permissions which you request.
