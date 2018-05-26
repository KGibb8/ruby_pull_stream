require "pull/source"
require "pull/sink"

module Pull
  class Stream
    def initialize(source, sink)

    end

    def values(array)
      Pull::Source.new(array)
    end

    def drain(callback)
      Pull::Sink.new(callback)
    end

    def collect(callback)
      Pull::Sink.new(callback)
    end
  end
end
