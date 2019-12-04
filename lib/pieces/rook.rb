require "./lib/piece"

class Rook < Piece
    
    def initialize(pos, player, game)
        @game = game
        @name = "ROOK"
        @position = pos
        @player = player
        @white_symbol = "♜"
        @black_symbol = "♖"
        @rel_moves = []

        ((1..7).to_a).each do |i|
            @rel_moves << [0, i] 
            @rel_moves << [(-1)*i, 0]
            @rel_moves << [0, (-1)*i]
            @rel_moves << [(-1)*i, 0]
        end
    end
end