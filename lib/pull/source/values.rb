# frozen_string_literal: true

module Pull
  class Values
    DEFAULT_ABORT_PROC = -> () {
      puts "abort abort"
    }

    def initialize(array, on_abort = DEFAULT_ABORT_PROC)
      array = objectify(array) unless array.kind_of?(Array)

      @array = array
      @index = 0
      @on_abort = on_abort
    end

    def call
      -> (finish, callback) {
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

    def objectify(object)
      if object.kind_of?(Hash)
        object.map { |k, v| v }
      else
        object.pretty_print_instance_variables.inject([]) do |coll, iv|
          coll << object.instance_variable_get(iv)
        end
      end
    end
  end
end
