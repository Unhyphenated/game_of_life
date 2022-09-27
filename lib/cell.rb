class Cell
    attr_reader :alive

    def initialize(alive)
        @alive = alive
    end

    def to_s
        return "1" if alive?
        return "0" if !alive?
    end

    def alive?
        @alive
    end

    def switch_state
        @alive = !@alive
    end
end
