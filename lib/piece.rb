class Piece
    attr_accessor :name, :player, :position, :moves, :white_symbol, :black_symbol
    
    def select
        get_all_moves
        get_legal_moves
    end

    def move(destination)
        opponent = @game.select_piece(destination)        
        @position = destination
        opponent
    end

    def remove
        @position = [-1,-1]
    end

    private
    
    def get_all_moves
    
        @moves = @rel_moves.select do |move|
            move[0] += @position[0]
            move[1] += @position[1]
            in_bounds?(move)
        end
    end
        
    def in_bounds?(move)
        move.all? { |element| element >= 0 && element <= 7 }
    end

end