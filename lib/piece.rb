class Piece
    attr_accessor :name, :player, :position, :moves, :white_symbol, :black_symbol
    
    def select
        get_moves
        refine_moves
    end

    def move(destination)
        @position = destination
    end

    private
    
    def get_moves
    
        @moves = @rel_moves.select do |move|
            move[0] += @position[0]
            move[1] += @position[1]
            valid_move?(move)
        end
    end
        
    def valid_move?(move)
        move.all? { |element| element >= 0 && element <= 7 }
    end

end