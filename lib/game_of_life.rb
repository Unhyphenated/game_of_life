require_relative "board.rb"

class GameOfLife
    attr_reader :board
    def initialize
        @board = Board.new(40, 40)
    end

    def run
        running = true

        until !running 
            sleep(0.05)
            system("clear")
            
            board.render
            board.next_board_state
        end
    end
end 

game = GameOfLife.new
game.run