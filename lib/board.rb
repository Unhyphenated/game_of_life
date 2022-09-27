require_relative "cell.rb"

class Board
    attr_reader :width, :height, :grid
    def initialize(width=3, height=3)
        @width, @height = width, height
        @grid = Array.new(width) { Array.new(height) { Cell.new(random_state) } }
        
        render
        next_board_state
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

    def board_array
        board_arr = Array.new(width) { Array.new() }

        board_positions.each do |pos|
            row, col = pos
            board_arr[row] << self[pos].to_s.to_i
        end
        board_arr
    end

    def next_board_state
        board_positions.each do |pos|
            cell_state(pos)
        end

        self.render
    end

    def board_positions
        all_positions = []
        (0...width).each do |row|
            (0...height).each do |col|
                all_positions << [row, col]
            end
        end
        all_positions
    end

    def cell_state(cell_pos)
        neighbors = neighbors(cell_pos)
        living_cells = living_cells(neighbors)

        alive = self.alive?(self[cell_pos])
 
        case alive
        when alive = true
            if living_cells <= 1 || living_cells > 3
                self[cell_pos].switch_state
            end
        when alive = false
            if living_cells == 3
                self[cell_pos].switch_state
            end
        end

    end

    def alive?(cell)
        cell.alive?
    end

    def living_cells(neighbors)
        living_cells = 0

        neighbors.each do |neighbor|
            next if !self.alive?(self[neighbor])
            living_cells += 1
        end

        living_cells
    end

    def neighbors(cell_pos)
        row, col = cell_pos
        neighbors = []

        (row - 1..row + 1).each do |new_row|
            (col - 1..col + 1).each do |new_col|
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
    
        row < width && row >= 0 &&
        col < height && col >= 0
    end

    def array_to_grid(arr)
        
    end

    def dup_board
        board_dup = self.dup
        board_dup
    end
end

b = Board.new
