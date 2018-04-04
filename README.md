# RenderAsJs

Simple Rails helper to render a ruby hash to a ES5/JavaScript object. While a hash like `{a:2}` in ruby looks like an acceptable object in JS-terms, `{a:2}.to_s`
renders to a string something along the lines of `{:a=>2}`. Which fails badly in any JS-interpreter. `#to_json` would work in most situations, but not all.
Hence `render_as_js` :)

Besides converting ruby's Hashes, this gem attempts to rerender the following things nicely in JS:

- Strings
- Date(Time)s
- Numbers
- Symbols
- Booleans
- `nil`s

Note: this is no attempt to compile ruby to JavaScript, I don't want to go there.

### Alternative

This almost does the same trick: `@data.to_json`. Sadly that doesn't work very nicely for dates.

### Warning

While sanitizing is done using the Rails `sanitize` helper; be really careful when passing unknown data through this gem (numbers and dates will (probably) be fine, but be careful with strings).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'render_as_js'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install render_as_js

## Usage

In your views try:

```ruby
complex_hash = [{y: 12, x:Date.new(2017,1,1)}, {y: 12, x: Date.new(2017,1,2)}]
render_as_js complex_hash
```

This should output in your generated html:

```javascript
[{y: 12, x: new Date('2017-01-01')}, {y: 12, x: new Date('2017-01-02')}]
```

The alternative with the standard `#to_json` is:

```javascript
[{"y": 12, "x": "2017-01-01"}, {"y": 12, "x": "2017-01-02"}]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/murb/render_as_js. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

