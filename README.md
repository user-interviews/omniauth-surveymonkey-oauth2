# OmniAuth for SurveyMonkey
[![Build Status](https://travis-ci.org/berk/omniauth-surveymonkey-oauth2.png?branch=master)](https://travis-ci.org/berk/omniauth-surveymonkey-oauth2)
[![Coverage Status](https://coveralls.io/repos/berk/omniauth-surveymonkey-oauth2/badge.png?branch=master)](https://coveralls.io/r/berk/omniauth-surveymonkey-oauth2?branch=master)
[![Gem Version](https://badge.fury.io/rb/omniauth-surveymonkey-oauth2.svg)](http://badge.fury.io/rb/omniauth-surveymonkey-oauth2)

SurveyMonkey OAuth2 Strategy for OmniAuth 1.0.

Supports the OAuth 2.0 server-side. Read the SurveyMonkey docs for more details: 

https://developer.surveymonkey.com/api/v3/#authentication

## Installing

This repo is just a fork of the original that fixes a bug and is not the same as the version on rubygems. In order to use this one add the following to your `Gemfile`:

```ruby
gem 'omniauth-surveymonkey-oauth2', git: "https://github.com/user-interviews/omniauth-surveymonkey-oauth2"
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
{"provider"=>"surveymonkey",
 "uid"=>"23421341234",
 "info"=>
  {"username"=>"userx",
   "account_type"=>"basic",
   "email"=>"user@domain.com",
   "id"=>"234123"},
 "credentials"=>
  {"token"=>
    "hBD-ASxyjkbtY-a89sdf9a78sd9f87as9d87fa98s7df9a78sdf987asd.J8OeyCHPcRx4y1R.Q.f2O5rmpBpgxl28hxkImYihxZvKGsdZh",
   "expires"=>false},
 "extra"=>
  {"username"=>"userx",
   "scopes"=>
    {"available"=>
      ["users_read",
       "surveys_read",
       "collectors_read",
       "collectors_write",
       "contacts_read",
       "contacts_write",
       "responses_read",
       "webhooks_read",
       "webhooks_write",
       "library_read"],
     "granted"=>
      ["surveys_read",
       "collectors_read",
       "collectors_write",
       "contacts_read",
       "contacts_write",
       "users_read"]},
   "account_type"=>"basic",
   "language"=>"en",
   "email"=>"user@domain.com",
   "href"=>"https://api.surveymonkey.net/v3/users/me",
   "date_last_login"=>"2017-05-06T15:10:37.837000+00:00",
   "date_created"=>"2016-07-23T00:02:00+00:00",
   "id"=>"23421341234"}} 
```

The precise information available may depend on the permissions which you request.
