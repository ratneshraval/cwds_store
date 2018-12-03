# CwdsStore

This gem provides a thin wrapper on Redis as session store. It inherits from `RedisStore` so you get all functionality of popular Redis session store.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cwds_store', github: 'ca-cwds/cwds_store'
```

And then execute:

    $ bundle

## Usage

Configure you application session store initializer file

```ruby
# config/initializers/session_store.rb
CountyAdmin::Application.config.session_store CwdsStore::Store, {
	host: ENV.fetch('REDIS_HOST', '127.0.0.1'),
	port: ENV.fetch('REDIS_PORT', '6379')
}
```

## Configurable options 

The gem needs `host` and `port` values supplied via options hash. The following example shows localhost options. Please use proper values for your redis. The example above uses env variables to set host and port that will be passed to the gem.

```ruby
{
    host: '127.0.0.1',
    port: 6379
}
```

## Default options

Following 2 options are configred inside the gem and you do not need to specify them. You will NOT be able to override them in your application. You will need to update the gem if these values need change

```ruby
namespace: 'cares:session:{guid}
expire_after: 4.hours
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` or `rspec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cwds_store.

## Questions

If you have any questions regarding the contents of this repository, please email the Office of Systems Integration at FOSS@osi.ca.gov.
