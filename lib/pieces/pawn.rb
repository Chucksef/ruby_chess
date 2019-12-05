require "./lib/piece"

class Pawn < Piece

    def initialize(pos, player, game)
        @game = game
        @name = "PAWN"
        @moved = false
        @position = pos
        @player = player
        @white_symbol = "♟"
        @black_symbol = "♙"
        @rel_moves = [[1,0], [-1,0], [2,0], [-2,0]]
    end

    def get_legal_moves
        @moves = @moves.select do |mv|
            #filter out self-occupied spaces
            if @game.get_piece(mv) != nil
                @game.get_piece(mv).player != @player
            else
                true
            end    
        end

        #filter out moves backwards for pawn
        dir = @player == "Black" ? -1 : 1
        @moves = @moves.select do |mv|
            ((@position[0] - mv[0]) <=> 0) == dir
        end

        #filter out moves 1 space forward/backward into an opponent
        @moves = @moves.select do |mv|
            if (@position[0] - mv[0]).abs == 1
                @game.get_piece(mv) == nil
            else
                true
            end
        end
        
        #filter out double move unless pawn has not moved yet
        @moves = @moves.select do |mv|
            if (@position[0] - mv[0]).abs == 2 && @moved == true
                false
            else
                true
            end
        end

        #add in diagonal attack if enemies present in forward direction diagonally
        opponents = []

        puts "is there a piece at [#{@position[0]-dir},#{@position[1]+1}]: #{@game.get_piece([@position[0]-dir, @position[1]+1])}"
        opponents << @game.get_piece([@position[0]-dir, @position[1]+1]) if @game.get_piece([@position[0]-dir, @position[1]+1])
        puts "is there a piece at [#{@position[0]-dir},#{@position[1]+1}]: #{@game.get_piece([@position[0]-dir, @position[1]-1])}"
        opponents << @game.get_piece([@position[0]-dir, @position[1]-1]) if @game.get_piece([@position[0]-dir, @position[1]-1])

        opponents.each do |opp|
            @moves << opp.position if opp.player != @player
        end
    end
end