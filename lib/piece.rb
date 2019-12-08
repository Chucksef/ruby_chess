class Piece
    attr_accessor :name, :player, :position, :moves, :moved, :white_symbol, :black_symbol
    
    def select
        # return nil if @game.current_player != @player
        @game.selected = @position
        get_all_moves
        get_legal_moves
    end

    def move(destination)
        #determine if piece is castelling
        displacement = (destination[1] - @position[1])
        dir = displacement > 0 ? 7 : 0
        castelling = @name == "KING" && displacement.abs > 1
        #if casteling, get correct rook based on direction and position
        if castelling
            rook = @game.get_piece([@position[0], dir])
            rook.move([@position[0], 5]) if dir > 1
            rook.move([@position[0], 2]) if dir < 1
        end

        opponent = @game.get_piece(destination)        
        @position = destination
        @moved = true
        opponent
    end

    def remove
        @game.pieces.delete(self)
    end

    private
    
    def get_all_moves
        @moves = []
        @rel_moves.each do |move|
            move = [move[0] + @position[0], move[1] + @position[1]]
            @moves << move if in_bounds?(move)
        end
    end
        
    def in_bounds?(move)
        move.all? { |element| element >= 0 && element <= 7 }
    end

end