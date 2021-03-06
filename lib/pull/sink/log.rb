# frozen_string_literal: true

module Pull
  class Log
    DEFAULT_DONE_CALLBACK = -> () {
      puts "DONE"
    }

    def call(read, done = DEFAULT_DONE_CALLBACK)
      raise TypeError unless read.respond_to?(:call)
      Pull::Drain.new do |value|
        puts value
      end.(read)
    end
  end
end
