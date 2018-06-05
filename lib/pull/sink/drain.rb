# frozen_string_literal: true

module Pull
  class Drain
    DEFAULT_DONE_CALLBACK = -> () {
      puts "DONE"
    }

    def initialize(&block)
      @block = block
      @continuing = true
    end

    def call(read, done = DEFAULT_DONE_CALLBACK)
      raise TypeError unless read.respond_to?(:call)
      while @continuing
        return done.() && break if !@continuing
        @continuing = read.(nil, -> (value) {
          block.call(value)
        })
      end
    end

    private

    attr_reader :block
  end
end

