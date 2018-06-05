# frozen_string_literal: true

module Pull
  class Take
    def initialize(limit)
      @limit = limit
      @index = 0
    end

    def call(read)
      return nil unless @index < @limit
      -> (finish, callback) {
        if finish
          on_abort.()
          return nil
        end

        read.(nil, -> (value) {
          callback.(value)
        })

        @index += 1
      }
    end
  end
end
