require "./lib/piece"
require "./lib/square"
require "./lib/pieces/rook"
require "./lib/pieces/pawn"
require "./lib/pieces/queen"
require "./lib/pieces/king"
require "./lib/pieces/bishop"
require "./lib/pieces/knight"

class Game
    attr_accessor :pieces, :selected

    def initialize
        @checkmate = false
        @selected = nil
        @current_player = "White"
        setup_initial_pieces
        setup_board
    end
    
    def play
        # main_menu
        show_board
        until @checkmate
            take_turn
        end
    end

    def get_piece(coords)
        @pieces.each do |piece|
            if piece.position == coords
                return piece
            end
        end
        nil
    end
    
    private

    def main_menu
        system "clear"
        puts "Welcome to Chess, or Whatever."
        puts ""
        puts "Press ENTER to begin a new game."
        gets
    end
    
    def setup_initial_pieces
        @pieces = []
        
        unless loaded
            #default piece placement

            #Black pieces
            @pieces << Rook.new([0,0], "Black", self)
            @pieces << Knight.new([0,1], "Black", self)
            @pieces << Bishop.new([0,2], "Black", self)
            @pieces << Queen.new([0,3], "Black", self)
            @pieces << King.new([0,4], "Black", self)
            @pieces << Bishop.new([0,5], "Black", self)
            @pieces << Knight.new([0,6], "Black", self)
            @pieces << Rook.new([0,7], "Black", self)
            @pieces << Pawn.new([1,0], "Black", self)
            @pieces << Pawn.new([1,1], "Black", self)
            @pieces << Pawn.new([1,2], "Black", self)
            @pieces << Pawn.new([1,3], "Black", self)
            @pieces << Pawn.new([1,4], "Black", self)
            @pieces << Pawn.new([1,5], "Black", self)
            @pieces << Pawn.new([1,6], "Black", self)
            @pieces << Pawn.new([1,7], "Black", self)
    
            #White pieces
            @pieces << Pawn.new([6,0], "White", self)
            @pieces << Pawn.new([6,1], "White", self)
            @pieces << Pawn.new([6,2], "White", self)
            @pieces << Pawn.new([6,3], "White", self)
            @pieces << Pawn.new([6,4], "White", self)
            @pieces << Pawn.new([6,5], "White", self)
            @pieces << Pawn.new([6,6], "White", self)
            @pieces << Pawn.new([6,7], "White", self)
            @pieces << Rook.new([7,0], "White", self)
            @pieces << Knight.new([7,1], "White", self)
            @pieces << Bishop.new([7,2], "White", self)
            @pieces << King.new([7,3], "White", self)
            @pieces << Queen.new([7,4], "White", self)
            @pieces << Bishop.new([7,5], "White", self)
            @pieces << Knight.new([7,6], "White", self)
            @pieces << Rook.new([7,7], "White", self)
            
            #test pieces go here

        end
    end

    def setup_board
        @spaces = []
        8.times do 
            row = []
            8.times { row << " " }
            @spaces << row
        end
        @pieces.each do |piece|
            x = piece.position[0]
            y = piece.position[1]
            z = piece.player == "Black" ? piece.black_symbol : piece.white_symbol
            @spaces[x][y] = z
        end
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
                # implement reverse color pattern: \e[7mTEXTHERE>\e[27m #{self}
                lines[0] += "     |"
                lines[1] += " "
                lines[1] += @selected == [row, col] ? "(" : " "
                lines[1] += "#{@spaces[row][col]}"
                lines[1] += @selected == [row, col] ? ")" : " "
                lines[1] += " |"
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
        # save state before move

        choice = nil
        piece = nil
        destination = nil

        until piece.is_a?(Piece)
            show_board
            puts "#{@current_player}: Choose a Piece (A1 - H8)\n\n"
            puts "#{choice}\n\n" if choice.is_a?(String)
            choice = validate_coords(gets.chomp)
            piece = get_piece(choice)
        end

        piece.select

        until destination
            show_board
            puts "Where would you like to move the #{piece.name} (A1 - H8)\n\n"
            destination = validate_coords(gets.chomp)
            destination = nil unless piece.moves.include?(destination)
        end

        opponent = piece.move(destination)
        opponent.remove if opponent

        @selected = nil
        setup_board
        show_board

        #Check for Checkmate

        #if checkmate against @player, reset and retake turn
        #if checkmate against opponent, @player wins
        #if no checkmate, switch @current_player
    end

    def validate_coords(string)
        
        return false if string.length != 2

        col = [string[0].upcase]
        row = [string[1].to_i]
        
        cols = ("A".."H").to_a
        rows = (1..8).to_a
        coords = []
        coords << col.map { |c| cols.index(c) }
        coords << row.map { |r| rows.index(r) }
        coords = [coords[1][0],coords[0][0]]
        
        return false if coords.include?(nil)
        coords

    end

    def remove_piece

    end

end