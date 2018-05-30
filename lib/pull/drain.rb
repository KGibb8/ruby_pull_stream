# frozen_string_literal: true

module Pull
  class Drain < Pull::Sink
    def initialize(callback)
      super(callback)
      @continuing = true
    end

    def call(read, done = nil)
      super(read, done)
      while @continuing
        return done.() && break if !@continuing
        @continuing = read.(nil, -> (value) {
          callback.(value)
        })
      end
    end
  end
end

