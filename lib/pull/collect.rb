# frozen_string_literal: true

module Pull
  class Collect < Pull::Sink
    def initialize(callback)
      super(callback)
      @collection = []
    end

    def call(read, done = nil)
      super(read, done)
      Pull::Drain.new(-> (value) {
        @collection << value
      }).(read)
      callback.(@collection)
    end
  end
end

