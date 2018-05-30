require "pull/source"
require "pull/sink"

module Pull
  class Stream
    def initialize(source, sink)
      @source = source
      @sink = sink
      self.call
    end

    protected

    def call
      sink.call(source.call)
    end

    private

    attr_reader :source, :sink
  end
end

# A pull stream basically does:
# sink(through(source(data)))
# source plucks individual values and sends through one at a time to the through and sink
