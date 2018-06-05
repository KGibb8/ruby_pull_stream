# frozen_string_literal: true

module Pull
  class Take
    def initialize(limit)
      @limit = limit
      @index = 0
    end

    def call(read)
      -> (finish, callback) {
        if finish
          on_abort.()
          return nil
        end

        read.(nil, -> (value) {
          return nil if @index >= @limit
          callback.(value)
          @index += 1
        })
      }
    end
  end
end
