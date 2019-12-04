require "./lib/piece"

class Bishop < Piece
    
    def initialize(pos, player, game)
        @game = game
        @name = "BISHOP"
        @position = pos
        @player = player
        @white_symbol = "♝"
        @black_symbol = "♗"
        @rel_moves = []

        ((1..7).to_a).each do |i|
            @rel_moves << [i, i] 
            @rel_moves << [(-1)*i, i]
            @rel_moves << [i, (-1)*i]
            @rel_moves << [(-1)*i, (-1)*i]
        end
    end
end