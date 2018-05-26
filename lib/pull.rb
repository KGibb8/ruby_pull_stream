require "pull/version"
require "pull/stream"
require "pull/helper"
# require "pull/errors"

module Pull
  def pull(*args)
    return Pull::Helper.new if args.empty?

    source = args.first
    raise StandardError unless source.kind_of? Pull::Source

    sink = args.last
    raise StandardError unless sink.kind_of? Pull::Sink

    Pull::Stream.new(source, sink)
  end
end
