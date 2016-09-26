[![Build Status](https://travis-ci.org/ehainer/voltron-encrypt.svg?branch=master)](https://travis-ci.org/ehainer/voltron-encrypt)

# Voltron::Encrypt

An attempt at giving rails models more obfuscated, base64 encoded id's, and therefore less lame looking urls.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'voltron-encrypt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install voltron-encrypt

Then run the following to create the voltron.rb initializer (if not exists already) and add the encrypt config:

    $ rails g voltron:encrypt:install

## Usage

Once installed, enable "encrypted" id's on rails models by placing `encrypted_id` at the top of your model.

```ruby
class User < ActiveRecord::Base

  encrypted_id

end
```

That's it. All url helper generated urls to the resource in question will receive a base 64 encoded id, i.e. - /users/bvE3j/edit

## Understanding the Options

#### Voltron.config.encrypt.seed

Determines how the base64 characters are randomized to help further obfuscate base64 encoded ids. Running `rake secret` will yield a string of characters that is plenty good. The most important thing is that this value be set once at the beginning of a project and never changed once id's have started to be generated. Changing it will change the randomization of the characters and will therefore change encoded/decoded ids, which equals very, very bad things happening.

#### Voltron.config.encrypt.offset

Since id's start at low numbers, their base 64 encoded values can look like "R" or "3" or "2x" Providing an offset value will case Voltron Encrypt to base 64 encode (id # + offset) and decode (decoded id - offset) That basically means another layer of obfuscation, and id's that don't look lame and more like actual id's.

#### Voltron.config.encrypt.blacklist

The blacklist file is a list of words that encoded id's are not permitted to "look like." Voltron Encrypt includes a fairly comprehensive list automatically, but you can always add/remove words as you please. When id's are created they are regex matched against all possible blacklisted words and, if matched, a new potential id is chosen.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ehainer/voltron-translate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
