require "./lib/piece"
require "./lib/square"
require "./lib/pieces/rook"
require "./lib/pieces/pawn"
require "./lib/pieces/queen"
require "./lib/pieces/king"
require "./lib/pieces/bishop"
require "./lib/pieces/knight"

class Game
    attr_accessor :pieces

    def initialize
        @checkmate = false
        @current_player = "White"
        set_up_pieces
        set_up_board
    end
    
    def play
        # welcome_message
        show_board
        unless @checkmate
            take_turn
        end
    end
    
    private

    def welcome_message
        system "clear"
        puts "Welcome to Chess, or Whatever."
        puts ""
        puts "Press ENTER to begin a new game."
        gets
    end
    
    def set_up_pieces
        @pieces = []
        @pieces << Rook.new([0,0], "b", self)
        @pieces << Knight.new([0,1], "b", self)
        @pieces << Bishop.new([0,2], "b", self)
        @pieces << Queen.new([0,3], "b", self)
        @pieces << King.new([0,4], "b", self)
        @pieces << Bishop.new([0,5], "b", self)
        @pieces << Knight.new([0,6], "b", self)
        @pieces << Rook.new([0,7], "b", self)
        @pieces << Pawn.new([1,0], "b", self)
        @pieces << Pawn.new([1,1], "b", self)
        @pieces << Pawn.new([1,2], "b", self)
        @pieces << Pawn.new([1,3], "b", self)
        @pieces << Pawn.new([1,4], "b", self)
        @pieces << Pawn.new([1,5], "b", self)
        @pieces << Pawn.new([1,6], "b", self)
        @pieces << Pawn.new([1,7], "b", self)

        @pieces << Pawn.new([6,0], "w", self)
        @pieces << Pawn.new([6,1], "w", self)
        @pieces << Pawn.new([6,2], "w", self)
        @pieces << Pawn.new([6,3], "w", self)
        @pieces << Pawn.new([6,4], "w", self)
        @pieces << Pawn.new([6,5], "w", self)
        @pieces << Pawn.new([6,6], "w", self)
        @pieces << Pawn.new([6,7], "w", self)
        @pieces << Rook.new([7,0], "w", self)
        @pieces << Knight.new([7,1], "w", self)
        @pieces << Bishop.new([7,2], "w", self)
        @pieces << King.new([7,3], "w", self)
        @pieces << Queen.new([7,4], "w", self)
        @pieces << Bishop.new([7,5], "w", self)
        @pieces << Knight.new([7,6], "w", self)
        @pieces << Rook.new([7,7], "w", self)
    end

    def set_up_board
        @spaces = []
        8.times do 
            row = []
            8.times { row << " " }
            @spaces << row
        end
        @pieces.each do |piece|
            x = piece.position[0]
            y = piece.position[1]
            z = piece.player == "b" ? piece.black_symbol : piece.white_symbol
            @spaces[x][y] = z
        end
    end
    
    def validate_coords(string)
        col = [string[0].upcase]
        row = [string[1].to_i]
        
        cols = ("A".."H").to_a
        rows = (1..8).to_a
        
        coords_x = col.map { |c| cols.index(c) }
        coords_y = row.map { |r| rows.index(r) }
        
        return [coords_x[0], coords_y[0]]
    end
    
    def show_board
        head = ""
        system "clear"
        puts ""
        puts "                CHESS OR WHATEVER"
        puts ""
        puts "   A     B     C     D     E     F     G     H"
        8.times {head += " _____"}
        puts head
        row = 0
        8.times do
            lines = Array.new(3) {"|"}
            col = 0
            8.times do
                lines[0] += "     |"
                lines[1] += "  #{@spaces[row][col]}  |"
                lines[2] += "_____|"
                col += 1
            end
            lines[1] += "  #{(1..8).to_a[row]}"
            lines.each {|l| puts l}
            row += 1
        end
        3.times {puts ""}
    end
    
    def take_turn
        #Ask user to select piece
        puts "#{@current_player}: Choose a Piece (A1 - H8)"
        #Display valid moves
        #Ask user to move piece
        #Check for Checkmate
    end
    
    def remove_piece

    end

end