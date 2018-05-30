# frozen_string_literal: true

module Pull
  class Log < Pull::Sink
    def call(read, done = nil)
      super(read, done)
      Pull::Drain.new(-> (value) {
        puts value
      }).(read)
    end
  end
end
