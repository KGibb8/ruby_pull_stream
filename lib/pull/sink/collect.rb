# frozen_string_literal: true

module Pull
  class Collect
    DEFAULT_DONE_CALLBACK = -> () {
      puts "DONE"
    }

    def initialize(&block)
      @block = block
      @collection = []
    end

    def call(read, done = DEFAULT_DONE_CALLBACK)
      raise TypeError unless read.respond_to?(:call)
      drained = Pull::Drain.new do |value|
        @collection << value
      end
      drained.(read)
      block.call(@collection)
    end

    private

    attr_reader :block
  end
end

