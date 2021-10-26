# EsteidLdap

This gem allows you to make queries to ESTEID LDAP for information about EE ident code (isikukood)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'esteid_ldap' or gem 'esteid_ldap', github: 'internetee/esteid_ldap', branch: :master
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install esteid_ldap

## Usage

In order to perform a search, you just need to add the line:

```ruby
require 'esteid_ldap'

esteid_ldap_instance = EsteidLdap::Search.new
esteid_ldap_instance.search_by_ident(code: '10101010005', with_data: true, in_json: true)
```

and that's all.

An instance of the Search class takes four parameters. By default, they have the following meanings:
```
  BASE = 'c=EE'
  HOST_ADDRESS = 'esteid.ldap.sk.ee'
  PORT = '636'
  SSL_METHOD = :simple_tls
```

These parameters can be overridden if necessary.
`EsteidLdap::Search.new(host: another.ldap.sk.ee', port: 777, ssl: nil, base: 'c=LV')`

The search class has only one open interface method `search_by_ident`.
This method takes three parameters: `code, with_data and in_json`, where `code` -this is the personal code of a resident of Estonia, `with_data` - this allows you to override, return data or return a boolean value, and the third parameter `in_json` - allows you to define in which structure to send a response, to json or as an instance of the structure

##Examples:

```ruby
e = EsteidLdap::Search.new
e.search_by_ident(code: '10101010005', with_data: true, in_json: true)
=>
  {:dn=>["cn=FirstName\\2LastName\\2C10101010005,ou=Authentication,o=Residence card of long-term resident,dc=ESTEID,c=EE"],
   :objectclass=>["top", "person", "organizationalPerson", "inetOrgPerson"],
   :cn=>["LastName,FirstName,10101010005"],
   :serialNumber=>["PNOEE-10101010005"],
   :"usercertificate;binary"=> 'some info'}

```

```ruby
e = EsteidLdap::Search.new
e.search_by_ident(code: '10101010005', with_data: true, in_json: false)
=>
  <struct EsteidLdap::Citizen
  :dn=>["cn=FirstName\\2LastName\\2C10101010005,ou=Authentication,o=Residence card of long-term resident,dc=ESTEID,c=EE"],
   :objectclass=>["top", "person", "organizationalPerson", "inetOrgPerson"],
   :cn=>["LastName,FirstName,10101010005"],
   :serialNumber=>["PNOEE-10101010005"],
   :"usercertificate;binary"=> 'some info'>
````

```ruby
e.search_by_ident(code: '10101010005', with_data: false, in_json: false)
=> true

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/internetee/esteid_ldap.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
