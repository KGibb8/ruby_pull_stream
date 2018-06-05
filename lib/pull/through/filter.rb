# frozen_string_literal: true

module Pull
  class Filter
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
          pass = block.call(value)
          callback.(value) if pass
        })
      }
    end

    private

    attr_reader :block
  end
end
