# ActiveEs

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/active_es`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active-es'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active-es

## Usage

### STEP1
#### Setting Config
Create config/searchengine.yml

See: spec/dummy/config/searchengine.yml

### STEP2
#### Inherit `ActiveEs::Base`

```
class Content < ActiveEs::Base
end
```

### STEP3
#### Define the property of model. 

format is `property :field_name, type: 'detatype', options... `
To check the specifiable detatype, execute the following command on rails console.

```
$ bundle exec rails console
$ > ActiveEs::Schema::Definition::FieldDetaTypes
```

FYI: spec/dummy/app/models/content.rb
```
class Content < ActiveEs::Base
  property :title, type: 'text', analyzer: 'kuromoji'
  property :description, type: 'text', analyzer: "kuromoji"
  property :number, type: 'integer'
  property :rank, type: 'integer'
end
```

## dummy app

$ bundle exec rails runner spec/dummy/db/seeds.rb
$ bundle exec rails console
$ => Content.all
$ => [#<Content:0x00007fffc5e958a0 @description="description2", @id="IhrI1mgBhOPWXkxafVfv", @number=2, @rank=2, @score=1.0, @title="title2">,
 #<Content:0x00007fffc5e94f90 @description="descripnumion10", @id="JBrI1mgBhOPWXkxaflfy", @number=10, @rank=10, @score=1.0, @title="title10">,
 #<Content:0x00007fffc5eab948 @description="description1", @id="IRrI1mgBhOPWXkxafVdk", @number=1, @rank=1, @score=1.0, @title="title1">,
 #<Content:0x00007fffc5eab3f8 @description="descripnumion20", @id="JRrI1mgBhOPWXkxaf1d1", @number=20, @rank=20, @score=1.0, @title="title20">,
 #<Content:0x00007fffc5eaa368 @description="description0", @id="IBrI1mgBhOPWXkxafFfP", @number=0, @rank=0, @score=1.0, @title="title0">,
 #<Content:0x00007fffc5ebb618 @description="descripnumion0", @id="IxrI1mgBhOPWXkxafld1", @number=0, @rank=0, @score=1.0, @title="title0">]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

# FYI
https://github.com/elastic/elasticsearch-ruby

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_es. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveEs project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/active_es/blob/master/CODE_OF_CONDUCT.md).
