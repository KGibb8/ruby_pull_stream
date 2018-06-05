# frozen_string_literal: true

module Pull
  class Map
    def initialize(&block)
      @block = block
    end

    def call(read)
      -> (finish, callback) {
        if finish
          on_abort.()
          return nil
        end

        read.(nil, -> (value) {
          callback.(block.call(value))
        })
      }
    end

    private

    attr_reader :block
  end
end
