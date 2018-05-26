module Pull
  class Helper
    def values(args)
      Pull::Source.new(args)
    end

    def drain(callback)
      Pull::Sink.new(callback)
    end
  end
end
