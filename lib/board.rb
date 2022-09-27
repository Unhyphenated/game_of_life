require_relative "cell.rb"

class Board
    attr_reader :width, :height, :grid, :file
    def initialize(width=20, height=20, file=nil)
        @width, @height = width, height

        if file
            @file = file
            new_grid = text_to_array(file)
            @width = new_grid.length
            @height = new_grid[0].length
            @grid = Array.new(@width) { Array.new(@height) { Cell.new(random_state) } }
            array_to_grid(new_grid)
        else
            @grid = Array.new(width) { Array.new(height) { Cell.new(random_state) } }
        end
    end

    # Converts file into grid
    def text_to_array(file)
        new_arr = File.readlines(file).map(&:chomp)
        new_grid = []
        new_arr.each do |str|
            set = Array.new
            str.each_char { |char| set << char.to_i }
            new_grid << set
        end
        
        new_grid
    end

    # Randomizes the state of a cell
    def random_state
        picker = rand(0..1)
        state = picker == 0 ? false : true
        state
    end

    # Renders the board
    def render
        puts "-" * width * 2
        puts "  " + "THE GAME OF LIFE"
        puts "-" * width * 2

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
        init_state = self.dup_board
        # init_state.render
        board_positions.each do |pos|
            cell_state(pos, init_state)
        end
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

    def cell_state(cell_pos, init_state)
        neighbors = neighbors(cell_pos)
        living_cells = living_cells(neighbors, init_state)

        alive = self.alive?(init_state[cell_pos])
 
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

    def living_cells(neighbors, init_state)
        living_cells = 0
        board_dup = self.dup_board

        neighbors.each do |neighbor|
            next if !self.alive?(board_dup[neighbor])
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
        
        raise "Array has wrong width or height" if arr.length != width || arr[0].length != height
        
        arr.each.with_index do |row, i|
            row.each.with_index do |cell, j| 
                if cell == 1
                    self[[i, j]] = Cell.new(true)
                else
                    self[[i, j]] = Cell.new(false)
                end
            end
        end
    end

    def dup_board
        board_dup = Board.new(width, height, file)
    end
end

