# frozen_string_literal: true

module Pull
  class Helper
    def values(args)
      Pull::Values.new(args)
    end

    def drain(callback)
      Pull::Drain.new(callback)
    end

    def collect(callback)
      Pull::Collect.new(callback)
    end

    def log
      Pull::Log.new
    end
  end
end
