# Ruby Pull Stream

A minimal pull based data streaming client for Ruby.

![sinking ducky](https://media.giphy.com/media/WV61B73quTNW8/giphy.gif)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pull_stream'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pull_stream

## Usage

In classic-streams, streams _push_ data to the next stream in the pipeline. With pull streams, data is pulled out of the source stream, into the destination. `pull_stream` is a Ruby implementation of a Javascript module [pull-stream](https://github.com/pull-stream/pull-stream) used by the [Scuttlebutt](http://scuttlebutt.nz/) community. It has been built as a means to improve my knowledge of pull-streams in Node. It may prove to be useful in Ruby though I am yet to conceive of an application.

`pull_stream` opens up a `pull` method that takes any number of arguments. The first must be a _source_. The last must be a _sink_. Any number of _through_'s can be added in the middle.

```ruby
pull(
  source,
  map,
  filter,
  take,
  sink
)
```

Simply include the `Pull` module into any class and begin pulling streams

```ruby
include Pull

ducks = ["Alice the Duck", "Gary the Gopher", "Bob the Duck", "Grace the Goose", "Elvis the Mallard"]

pull(
  pull.values(ducks),
  # Lets objectify our ducks
  pull.map( -> (duck) {
    name, type = duck.split(" the ")
    OpenStruct.new(name: duck, type: type)
  }),
  # Lets make sure we've only got ducks, this filters out Gary, sorry Gary
  pull.filter( -> (duck) { duck.type != "Duck" }),
  # Lets make sure we've only got ducks, this filters out Gary, sorry Gary
  pull.filter( -> (duck) { duck.type != "Duck" }),
  # Turns out Alice and Bob are actually Pochards, a specific type of duck
  pull.map( -> (duck) {
    duck.tap { |d| d.type.gsub(/Duck/, /Pochard/) }
  }),
  # Group all the remaining ducks together...
  pull.collect(-> (ducks) {
    # and show your ducks
    puts ducks.map { |d| "#{d.name}: #{d.type}" }.join("\n")
  })
)

# Alice: Pochard
# Bob: Pochard
# Grace: Goose
# Elvis: Mallard
```

If a _sink_ is not provided, pull returns itself as a source, and can be used in another pull stream.

```ruby
source = pull(
  pull.values([1, 2, 3, 4, 5]),
  pull.map(-> (value) { value ** 2 })
)

pull(
  source,
  # Apply more throughs and a sink
)
```

### Pull Stream's API

```
pull.values # source
pull.keys # source
pull.infinity # source

pull.map # through
pull.filter # through
pull.take # through

pull.drain # sink
pull.collect # sink
pull.log # sink
pull.reduce # sink
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kgibb8/pull_stream_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pull Stream project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pull/blob/master/CODE_OF_CONDUCT.md).
