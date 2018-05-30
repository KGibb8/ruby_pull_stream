# frozen_string_literal: true

require "pull/source"

module Pull
  class Values < Pull::Source
    DEFAULT_ABORT_PROC = -> () {
      puts "abort abort"
    }

    def initialize(array, on_abort = DEFAULT_ABORT_PROC)
      raise TypeError unless array.kind_of?(Array)

      @array = array
      @index = 0
      @on_abort = on_abort
    end

    def call
      return -> (finish, callback) {
        if finish
          on_abort.()
          return nil
        end

        return false if !array[@index]

        callback.(array[@index])
        @index += 1
        return true
      }
    end

    private

    attr_reader :array, :on_abort
  end
end
