require "./lib/piece"

class Pawn < Piece

    def initialize(pos, player, game)
        @game = game
        @name = "PAWN"
        @moved = false
        @position = pos
        @player = player
        @white_symbol = "♟"
        @black_symbol = "♙"
        @rel_moves = [[0,1]]
    end
end