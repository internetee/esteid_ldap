# EsteidLdap

This gem allows you to make queries to ESTEID LDAP for information about EE ident code (isikukood)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'esteid_ldap'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install esteid_ldap

## Usage

In order to perform a search, you just need to add the line:

```ruby
EsteidLdap.search_by_ident('10101010005', false)
```

or

```ruby
EsteidLdap.search_by_ident('10101010005', true)
```

and that's all.

The method accepts two arguments: the first argument is the ident code, the second argument is the flag - to return a response with data or not.

If the flag is set to false, then the response will be only two states - true or false. This is necessary in order to check whether such a personal code exists or not.

The other state of the flag is true - in this case, information about its carrier is returned to the request for a personal code.

The information comes in the form of JSON with the following keys:

```ruby
result = EsteidLdap.search_by_ident('10101010005', true)

result[:dn]
result[:objectclass]
result[:cn]
result[:serialNumber]
result[:"usercertificate;binary"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/internetee/esteid_ldap.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
