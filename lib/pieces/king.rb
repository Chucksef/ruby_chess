require "./lib/piece"

class King < Piece
    
    def initialize(pos, player, game)
        @game = game
        @name = "KING"
        @position = pos
        @player = player
        @white_symbol = "♚"
        @black_symbol = "♔"
        @rel_moves = [[1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1, 0], [-1,1], [0,1]]
        
    end

    def get_legal_moves
        @moves = @moves.select do |move|
            #filter out self-occupied spaces
            if @game.get_piece(move) != nil
                @game.get_piece(move).player != @player
            else
                true
            end

        end
    end
end