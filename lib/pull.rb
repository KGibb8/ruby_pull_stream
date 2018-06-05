# frozen_string_literal: true

require "pull/version"

require "pull/source/values"

require "pull/through/map"
require "pull/through/filter"
require "pull/through/take"

require "pull/sink/drain"
require "pull/sink/collect"
require "pull/sink/log"

require "pull/helper"

module Pull
  def pull(*args)
    return Pull::Helper.new if args.empty?
    recurse(nil, args)
    true
  end

  private

  def recurse(streamer, args)
    return if args.empty?
    arg = args.shift
    raise TypeError unless arg.respond_to?(:call)

    recurse(
      streamer.nil? ? arg.() : arg.(streamer),
      args
    )
  end
end
