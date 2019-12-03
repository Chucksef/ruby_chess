require "./lib/piece"
require "./lib/square"
require "./lib/pieces/rook"
require "./lib/pieces/pawn"
require "./lib/pieces/queen"
require "./lib/pieces/king"
require "./lib/pieces/bishop"
require "./lib/pieces/knight"

class Game

    def initialize
        @pieces = set_up_pieces
    end
    
    def play
        welcome_message

    end
    
    private

    def welcome_message
        
    end
    
    def set_up_pieces
        spaces = []
        8.times do
            spaces << Array.new(8) {" "}
        end
        spaces
    end

    def print_board
        head = ""
        system "clear"
        puts ""
        puts "                        CHESS OR WHATEVER"
        puts ""
        puts "    A       B       C       D       E       F       G       H"
        8.times {head += " _______"}
        puts head
        row = 0
        8.times do
            lines = Array.new(4) {"|"}
            col = 0
            8.times do
                lines[0] += "       |"
                lines[1] += "       |"
                lines[2] += "   #{@pieces[row][col]}   |"
                lines[3] += "_______|"
                col += 1
            end
            lines[2] += "  #{(1..8).to_a[row]}"
            lines.each {|l| puts l}
            row += 1
        end
        3.times {puts ""}
    end
    
    def take_turn
        #Address user
        #Ask user to select piece
        #Display valid moves
        #Ask user to move piece
        #Check for Checkmate
    end
    
    def remove_piece

    end

    def spawn_knight
        puts "Choose a space to put your knight (format: A1 - H8)"
        puts ""
        start = gets.chomp
        2.times {puts ""}
        kn = Knight.new(start)

        add_piece(kn)
        add_targets(kn)

        puts "Now set the ending point for where you want the knight to go."
        puts ""
        ending = gets.chomp

        knight_moves(kn, ending)
    end

    def add_piece(piece)
        @pieces[piece.position[1]][piece.position[0]] = piece.symbol
        print_board
    end

end