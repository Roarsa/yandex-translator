# Yandex::Translator

```ruby
require "yandex-translator"
@Translator = Yandex::Translator.new(api_key)
#Use the function "get_languages" to get information about all available languages. 
#Arguments: the language in which the names of languages will be displayed.
@Translator.get_languages('en')
#Use the function to determine the language in which the text is written. 
#Arguments: text, list of languages to be checked first. 
#The second argument may be omitted.
@Translator.define_languages('Hello World', 'en, ru, de')
#Use the function to translate text. 
#Arguments: text, 
#language into which the translation will be made, 
#original language, 
#format (plain - text without markup (default value); html - text in HTML format). 
#The last two arguments can be omitted.
@Translator.translate_text('Hello World', 'ru', 'en')
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yandex-translator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yandex-translator


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Roarsa/yandex-translator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Yandex::Translator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Roarsa/yandex-translator/blob/master/CODE_OF_CONDUCT.md).
