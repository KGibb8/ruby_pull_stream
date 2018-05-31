# frozen_string_literal: true

module Pull
  class Drain < Pull::Sink
    def initialize(callback)
      super(callback)
      @continuing = true
    end

    def call(read, done = DEFAULT_DONE_CALLBACK)
      super(read)
      while @continuing
        return done.() && break if !@continuing
        @continuing = read.(nil, -> (value) {
          callback.(value)
        })
      end
    end
  end
end

