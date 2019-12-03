class Piece
    attr_accessor :position, :moves, :white_symbol, :black_symbol
    
    @@rel_moves = []
    def initialize(pos, player)
        @position = get_coords(pos)
        @white_symbol = "X"
        @black_symbol = "x"
        @player = player
        get_moves
    end
    
    private
    
    def get_moves
    
        @moves = @@rel_moves.select do |move|
            move[0] += @position[0]
            move[1] += @position[1]
            valid_move?(move)
        end
    end
        
    def valid_move?(move)
        move.all? { |element| element >= 0 && element <= 7 }
    end
    
    def get_coords(string)
        col = [string[0].upcase]
        row = [string[1].to_i]
        
        cols = ("A".."H").to_a
        rows = (1..8).to_a
        
        coords_x = col.map { |c| cols.index(c) }
        coords_y = row.map { |r| rows.index(r) }
        
        return [coords_x[0], coords_y[0]]
    end
    
end