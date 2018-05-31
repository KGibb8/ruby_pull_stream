# frozen_string_literal: true

module Pull
  class Collect < Pull::Sink
    def initialize(callback)
      super(callback)
      @collection = []
    end

    def call(read, done = DEFAULT_DONE_CALLBACK)
      super(read)
      Pull::Drain.new(-> (value) {
        @collection << value
      }).(read)
      callback.(@collection)
    end
  end
end

