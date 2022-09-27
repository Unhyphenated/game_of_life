require_relative "board.rb"

class GameOfLife
    attr_reader :board
    def initialize(file=nil)
        @board = Board.new(3, 3, file)
    end

    def run
        running = true
        until !running do
            # system("clear")
            sleep(0.2)
            system("clear")
            board.next_board_state
            board.render
        end
    end
end 

# game = GameOfLife.new("/Users/julianj/Documents/Projects/Programming/practice_projects/game_of_life/lib/toad.txt")
game = GameOfLife.new("/Users/julianj/Documents/Projects/Programming/practice_projects/game_of_life/lib/toad.txt")
game.run
