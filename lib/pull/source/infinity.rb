# frozen_string_literal: true

module Pull
  class Infinity < Pull::Source
    def initialize(on_abort = DEFAULT_ABORT_PROC)
      @index = 0
    end

    def call
      -> (finish, callback) {
        if finish
          on_abort.()
          return nil
        end

        callback.(@index)
        @index += 1
        return true
      }
    end
  end
end
