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
        @can_castle_right = false
        @can_castle_left = false
        @moved = false
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

        if @player == "White"
            row = []
            return if @moved
            (0..7).to_a.each do |n|
                row << @game.get_piece([7,n])
            end

            @can_castle_left = (row[0].name == "ROOK" && row[0].moved == false && row[1] == nil && row[2] == nil && row[3].name == "KING" && row[3].moved == false) unless row[0] == nil
            @can_castle_right = (row[3].name == "KING" && row[3].moved == false && row[4] == nil && row[5] == nil && row[6] == nil && row[7].name == "ROOK" && row[7].moved == false) unless row[7] == nil
            @moves << [7,1] if @can_castle_left
            @moves << [7,6] if @can_castle_right
        else
            row = []
            return if @moved
            (0..7).to_a.each do |n|
                row << @game.get_piece([0,n])
            end

            @can_castle_left = (row[0].name == "ROOK" && row[0].moved == false && row[1] == nil && row[2] == nil && row[3] == nil && row[4].name == "KING" && row[4].moved == false) unless row[0] == nil
            @can_castle_right = (row[4].name == "KING" && row[4].moved == false && row[5] == nil && row[6] == nil && row[7].name == "ROOK" && row[7].moved == false) unless row[7] == nil
            @moves << [0,1] if @can_castle_left
            @moves << [0,6] if @can_castle_right
        end
    end
end