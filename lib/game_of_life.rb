require_relative "board.rb"

class GameOfLife
    attr_reader :board
    def initialize(file=nil)
        @board = Board.new(10, 10, file)
    end

    def run
        running = true
        until !running do
            sleep(0.2)
            system("clear")
            board.next_board_state
            board.render
        end
    end
end 

game = GameOfLife.new
game.run
