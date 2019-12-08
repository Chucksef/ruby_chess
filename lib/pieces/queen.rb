require "./lib/piece"

class Queen < Piece
    
    def initialize(pos, player, game)
        @game = game
        @name = "QUEEN"
        @position = pos
        @player = player
        @white_symbol = "♛"
        @black_symbol = "♕"
        @rel_moves = []
        @moved = false
    end

    def get_legal_moves
        @moves = []
        directions = [[0,1], [1,0], [0,-1], [-1,0], [1,1], [-1,1], [-1,-1], [1,-1]]

        ((1..7).to_a).each do |i|
            directions.each_with_index do |dir, idx|
                test_coords = [@position[0] + (dir[0] * i), @position[1] + (dir[1] * i)]
                next if test_coords[0] > 7 || test_coords[0] < 0 || test_coords[1] > 7 || test_coords[1] < 0
                piece = @game.get_piece(test_coords)
                if piece != nil
                    @moves << test_coords if piece.player != @player 
                    directions[idx] = [-200,-200]
                else 
                    @moves << test_coords
                end
            end
        end
    end
end