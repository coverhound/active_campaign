# ActiveCampaign

Welcome to your Active Campaign navigator! This gem allows you to make API calls
without having to experience the real life ActiveCampaign API!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_campaign', github: "coverhound/active_campaign"
```

And then execute:

    $ bundle


## Usage

Before you can use ActiveCampaign, you will have to register clients! You can do
so like this:

```ruby
ActiveCampaign.register_client(:client_name) do |config|
  config.email = "david@example.com"
  config.api_key = "fdalsdjf1242139210"
end

# can later be called like this:
ActiveCampaign.client(:client_name)
```

If you want your client to be the default client, you'll want to set it up like
this instead:

```ruby
ActiveCampaign.register_client(:default_client, default: true) do |config|
# ...
end

# can later be called like this:
ActiveCampaign.client
```

Once you have that set up, you can get rolling. API resources are passed into
the client to perform their actions. For example, to create a new contact, you
would do this:

```ruby
client = ActiveCampaign.client
contact = ActiveCampaign::Contact.new(email: "hi@example.com")
client.create!(contact)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Creating a resource
The 5 actions currently supported are:
- `create` Creates the resource
- `update` Updates the resource
- `delete` Deletes the resource
- `find` Finds the resource
- `list` Gets a list of resources

You can create a new resource like this:

```ruby
module ActiveCampaign
  class Friend < Resource
    # Add your required attributes here - by default a resource will take any
    # and all parameters that a user gives it
    def initialize(required_attribute:, **params)
      @params = { required_attribute: required_attribute }.merge(params)
    end

    # The key of each action is one of our 5 supported actions
    # The value of each action is the corresponding ActiveCampaign action
    action create: :friend_add
    action update: :friend_edit
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/coverhound/active_campaign.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

