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

    def get_legal_moves
        @moves = []
        directions = [[0,1], [1,0], [0,-1], [-1,0]]

        ((1..7).to_a).each do |i|
            directions.each_with_index do |dir, idx|
                test_coords = [@position[0] + (dir[0] * i), @position[1] + (dir[1] * i)]
                next if test_coords[0] > 7 || test_coords[0] < 0 || test_coords[1] > 7 || test_coords[1] < 0
                piece = @game.get_piece(test_coords)
                if piece != nil
                    @moves << test_coords if piece.player != @player 
                    directions[idx] = [-200,-200]
                else 
                    puts "adding #{test_coords} to the list"
                    @moves << test_coords
                end
            end
        end
        
        puts
        puts "legal moves:"
        @moves.each {|x| puts x.to_s}
    end
end