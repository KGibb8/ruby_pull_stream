# frozen_string_literal: true

module Pull
  class Helper
    def values(args)
      Pull::Values.new(args)
    end

    def infinity
      Pull::Infinity.new
    end

    def drain(&block)
      Pull::Drain.new(&block)
    end

    def collect(&block)
      Pull::Collect.new(&block)
    end

    def map(&block)
      Pull::Map.new(&block)
    end

    def filter(&block)
      Pull::Filter.new(&block)
    end

    def take(limit)
      Pull::Take.new(limit)
    end

    def log
      Pull::Log.new
    end
  end
end
