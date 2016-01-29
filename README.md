# Gracenote-Rb

[![Build Status](https://travis-ci.org/tomoya55/gracenote-rb.svg?branch=master)](https://travis-ci.org/tomoya55/gracenote-rb)

Gracenote client for modern Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gracenote-rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gracenote-rb

## Usage

### Registration

Run this snippet only once and your keep your user_id somewhere.

```
> require 'gracenote-rb'
> Gracenote::Client.new(client_id: 'XXXXXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX').register
> F3180SG7792B09ZPN7-UFC6XA8FV3RQ80K0RO7FURV76GQSDM16
```

### Search

```
> require 'gracenote-rb'
> client = Gracenote::Client.new(client_id: 'XXXXXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', user_id: 'F3180SG7792B09ZPN7-UFC6XA8FV3RQ80K0RO7FURV76GQSDM16')
> client.search(artist: "Suchmos")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gracenote-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
