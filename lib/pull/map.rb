# frozen_string_literal: true

module Pull
  class Map < Pull::Transition
    def initialize(mapper)
      raise TypeError unless mapper.respond_to?(:call)

      @mapper = mapper
    end

    def call(read)
      -> (finish, callback) {
        if finish
          on_abort.()
          return nil
        end

        read.(nil, -> (value) {
          callback.(mapper.(value))
        })
      }
    end

    private

    attr_reader :mapper
  end
end
