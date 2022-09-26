require_relative "cell.rb"

class Board
    attr_reader :width, :height, :grid
    def initialize(width=5, height=5)
        @width, @height = width, height
        @grid = Array.new(width) { Array.new(height) { Cell.new(random_state) } }
        render
    end

    # Randomizes the state of a cell
    def random_state
        picker = rand(0..1)
        state = picker == 0 ? false : true
        state
    end

    # Renders the board
    def render
        puts "-" * width
        puts "THE GAME OF LIFE"
        puts "-" * width

        grid.each do |row| 
            puts row.map(&:to_s).join(" ")
        end
    end

    def next_board_state
        
        
    end

    def cell_state(living_cells)
        
    end

    def living_cells(neighbors)
        living_cells = 0

        neighbors.each do |neighbor|
            next if !self[neighbor].alive?
            living += 1
        end

        living_cells
    end

    def neighbors(cell_pos)
        row, col = cell_pos
        neighbors = []

        (0..row + 1).each do |new_row|
            (0..col + 1).each do |new_col|
                next unless valid_pos?([new_row, new_col])
                next if [new_row, new_col] == cell_pos
                neighbors << [new_row, new_col] 
            end
        end

        neighbors
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, val)
        row, col = pos
        @grid[row][col] = val
    end

    def valid_pos?(pos)
        row, col = pos
        row <= width && col <= height
    end
end

b = Board.new
b.cell_state(b.neighbors([1, 1]))