require_relative "cell.rb"

class Board
    attr_reader :size, :grid
    def initialize(size=8)
        @grid = Array.new(size) { Array.new(size) { Cell.new(random_state) } }
        display
    end

    def random_state
        picker = rand(0..1)
        state = picker == 0 ? false : true
        state
    end

    def display
        grid.each do |row| 
            puts row.map(&:to_s).join(" ")
        end
    end
end

b = Board.new