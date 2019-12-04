require "./lib/piece"

class King < Piece
    
    def initialize(pos, player, game)
        @game = game
        @position = pos
        @player = player
        @white_symbol = "♚"
        @black_symbol = "♔"
        @rel_moves = [[1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1, 0], [-1,1], [0,1]]
    end
end