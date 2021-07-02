# Statuspageio

Ruby gem for the [Statuspage REST API](https://developer.statuspage.io).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'statuspageio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install statuspageio

## Usage

##### In plain Ruby

```ruby
client = Statuspageio::Client.new(api_key: '<your_api_key>', page_id: '<your_page_id>')

# get a list of all your incidents
client.incidents

# get incidents scoped by their status
client.incidents(:active_maintenance)
client.incidents(:scheduled)
client.incidents(:unresolved)
client.incidents(:upcoming)

# pagination support
client.incidents(limit: 20, page: 2)

# query support
client.incidents(query: 'AWS is down')

# fetch an incident
client.incident(<incident_id>)

# create an incident (see [docs](https://developer.statuspage.io) for payload)
client.create_incident(<incident payload>)

# update an incident
client.update_incident(<incident_id>, payload)

# delete an incident
client.delete_incident(<incident_id>)

```

##### In Rails you can configure using an initializer

`config/intializers/statuspage.rb`

```ruby
Statuspageio.configure do |config|
  config.api_key = ENV['STATUSPAGE_API_KEY']
  config.page_id = ENV['STATUSPAGE_PAGE_ID']
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/statuspageio.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
