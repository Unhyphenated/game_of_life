require_relative "cell.rb"

class Board
    attr_reader :size, :grid
    def initialize(size=8)
        @grid = Array.new(size) { Array.new(size, Cell.new) }
        display
    end

    
    def display
        grid.each do |row| 
            puts row.map(&:to_s).join(" ")
        end
    end
end

b = Board.new