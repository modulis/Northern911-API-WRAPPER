# Northern911Api

A simple Rails friendly API wrapper for Northern911Api's SOAP based API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'Northern911Api', git: 'https://github.com/modulis/Northern911-API-WRAPPER.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Northern911Api

## Usage
### Configuration
First you must configure Northern911Api or you won't be able to make requests.
```ruby
Northern911Api.configure do |config|
  config.vendor_code = '427' # Your api username given to you by Northern911Api
  config.soap_passcode = '#9mB@j3X' # Your secret api key given to you by Northern911Api
  config.sandbox = false # Optional. True by default, you must set it to live manually.
end
```

### Building the client
You can create a client which will inheret Northern911Api configuration automatically using
```ruby
client = Northern911Api::Client.new
```

If you would like to change the configuration for a specific client you'll have to do so manually:
```ruby
client.configuration.sandbox = false # sets this client to live mode
```

### Some examples
```ruby
client = Northern911Api::Client.new
client.addor_update_customer(customer: {...}) # see Customer fields below
client.query_customer({phone_number: '5142842020'})
client.delete_customer({phone_number: '5142842020'})
```

### Customer object should contains
```ruby
:city, :first_name, :last_name, :other_address_info, :phone_number, :realm_id, :postal_code_zip, :province_state, :street_name, :street_number, :suite_apt
```

### Available methods
```ruby
[:addor_update_customer, :delete_customer, :query_customer, :get_vendor_dump_url, :verify_customer]
```

### Official API doc
https://addressinfo.northern911.com/soapapidocs/


### Convenience methods
Northern911Api has a few convenience methods to use in your code:
```ruby
Northern911Api.configure do |config|
  config.vendor_code = '427' # Your api username given to you by Northern911Api
  config.soap_passcode = '#9mB@j3X' # Your secret api key given to you by Northern911Api
  config.sandbox = false # Optional. True by default, you must set it to live manually.
end
```

## Development

You have access to a developer console to use the gem interactively by running `bin/console` from the project directory.
Please write specs for any additions, and use shared examples when possible.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/modulis/Northern911-API-WRAPPER.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
