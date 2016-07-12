# KolektiMetricfu

[![Code Climate](https://codeclimate.com/github/mezuro/kolekti_metricfu/badges/gpa.svg)](https://codeclimate.com/github/mezuro/kolekti_metricfu) <a href="https://codeclimate.com/github/mezuro/kolekti_metricfu/coverage"><img src="https://codeclimate.com/github/mezuro/kolekti_metricfu/badges/coverage.svg" /></a>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kolekti_metricfu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kolekti_metricfu

### Important note about Ruby versions older than 2.2.2

KolektiMetricFu depends on [activesupport](https://github.com/rails/activesupport) to work.
AS version 5 dropped support for Ruby versions older than 2.2.2. Unfortunately,
RubyGems does not take that into account while selecting a Gem version to be installed.
It will attempt to install version 5 and fail in many cases.

If your project is not using Rails (which will already lock the AS version to it's own),
you need to add the following snippet to your Gemfile if you want to keep support
for those old Ruby versions.

```ruby
# Active Support 5 drops Ruby < 2.2.2 support. We still want to support it, so
# manually add a maximum version bound for incompatible Ruby versions.
if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('2.2.2')
    gem 'activesupport', '< 5'
end
```

If you are installing KolektiMetricFu manually as outlined earlier, you must install a version
of f AS compatible with your Ruby installation first, by running the following command:

    gem install activesupport -v '< 5'

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kolekti_metricfu.

