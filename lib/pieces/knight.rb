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

    def get_legal_moves
        @moves = @moves.select do |move|
            #filter out self-occupied spaces
            if @game.get_piece(move) != nil
                @game.get_piece(move).player != @player
            else
                true
            end
            #filter out l-o-s blocked spaces

        end
    end
end