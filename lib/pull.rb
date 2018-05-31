# frozen_string_literal: true

require "pull/version"
require "pull/source"
require "pull/transition"
require "pull/sink"
require "pull/stream"
require "pull/values"
require "pull/map"
require "pull/drain"
require "pull/collect"
require "pull/helper"

module Pull
  def pull(*args)
    return Pull::Helper.new if args.empty?

    # Actually we want to defer the pull_stream if a source is not provided
    source = args.first
    raise StandardError unless source.to_s == "source"

    # Actually we want to defer the pull_stream if a sink is not provided
    sink = args.last
    raise StandardError unless sink.to_s == "sink"

    Pull::Stream.new(source, sink)
  end
end
