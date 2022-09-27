require "board"

describe Board do
    describe "#next_board_state" do
        dead_cells = [ 
            [0,0,0],
            [0,0,0],
            [0,0,0] 
        ]

        let(:dead_board) { Board.new(3, 3, dead_cells)}

        context "dead cells with no live neighbors" do
            it "should leave those cells dead" do
                expect(dead_board.board_array).to eq(
                    [ 
                        [0,0,0],
                        [0,0,0],
                        [0,0,0] 
                    ]
                )
            end
        end

        context "dead cells with exactly 3 neighbors" do
            reviving_cells = [
                [0,0,1],
                [0,1,1],
                [0,0,0]
            ]
            
            let(:reviving_board) { Board.new(3, 3, reviving_cells) }
            it "should revive those cells" do
                expect(reviving_board.board_array).to eq(
                    [ 
                        [0,1,1],
                        [0,1,1],
                        [0,0,0] 
                    ]
                )
            end
        end
    end
end