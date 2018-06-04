# frozen_string_literal: true

module Pull
  class Filter < Pull::Transition
    def initialize(&block)
      raise TypeError unless block.respond_to?(:call)

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
