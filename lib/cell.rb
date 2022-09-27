class Cell
    attr_reader :alive

    def initialize(alive)
        @alive = alive
    end

    def to_s
        return "*" if alive?
        return " " if !alive?
    end

    def alive?
        @alive
    end

    def switch_state
        @alive = !@alive
    end
end
