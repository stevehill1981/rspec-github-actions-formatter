# rspec-github-actions-formatter

This is a custom formatter for use with RSpec 3.9 and above.

It's designed to integrate with GitHub Actions, so that failing and
pending specs are annotated correctly, but it also solves an issue
I had with the way that actions handles streaming to STDOUT.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-github-actions-formatter'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rspec-github-actions-formatter

If you're using this with Rails, you can probably just add it to
the `test` group in your Gemfile.

## Usage

Once you've installed the gem, you'll need to tell Rspec to use it.
This can be done by adding this line to the `.rspec` file:

    --format RspecGithubActionsFormatter
    
You could also require it directly when executing RSpec:

    $ bundle exec rspec --format RspecGithubActionsFormatter

The annotations output won't be very useful unless you're executing
your tests within GitHub Actions, but the progress display is quite
useful no matter where you run your tests!

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rspec-github-actions-formatter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/rspec-github-actions-formatter/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rspec::Github::Actions::Formatter project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rspec-github-actions-formatter/blob/master/CODE_OF_CONDUCT.md).
