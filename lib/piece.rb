class Piece
    attr_accessor :name, :player, :position, :moves, :white_symbol, :black_symbol
    
    def select
        @game.selected = @position
        get_all_moves
        get_legal_moves
    end

    def move(destination)
        opponent = @game.get_piece(destination)        
        @position = destination
        @moved = true
        opponent
    end

    def remove
        @game.pieces.delete(self)
        @game.pieces.each do |x|
            puts "#{x.position}: #{x.name}"
        end
        gets
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