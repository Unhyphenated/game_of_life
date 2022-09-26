class Cell
    attr_reader :alive

    def initialize(alive=true)
        @alive = alive
    end

    def to_s
        print "1" if alive?
        print "0" if !alive?
    end

    def alive?
        @alive
    end

end
