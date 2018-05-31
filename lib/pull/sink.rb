module Pull
  class Sink
    DEFAULT_DONE_CALLBACK = -> () {
      puts "DONE"
    }

    def initialize(callback)
      raise TypeError unless callback.respond_to?(:call)

      @callback = callback
    end

    def call(read, done = DEFAULT_DONE_CALLBACK)
      raise TypeError, 'read: provide an object that executes a callback' unless read.respond_to?(:call)
    end

    def to_s
      "sink"
    end

    private

    attr_reader :callback
  end
end
