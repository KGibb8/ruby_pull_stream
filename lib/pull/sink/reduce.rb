# frozen_string_literal: true

module Pull
  class Reduce
    DEFAULT_DONE_CALLBACK = -> () {
      puts "DONE"
    }

    def initialize(accumulator, &block)
      @accumulator = accumulator
      @block = block
    end

    def call(read, done = DEFAULT_DONE_CALLBACK)
      raise TypeError unless read.respond_to?(:call)
      drained = Pull::Drain.new do |value|
        @accumulator = block.call(@accumulator, value)
      end
      drained.(read)
    end

    private

    attr_reader :block
  end
end
