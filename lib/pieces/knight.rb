require "./lib/piece"

class Knight < Piece
    
    def initialize(pos, player, game)
        @game = game
        @name = "KNIGHT"
        @position = pos
        @player = player
        @white_symbol = "♞"
        @black_symbol = "♘"
        @rel_moves = [[1,2], [2,1], [2,-1], [1,-2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    end
end