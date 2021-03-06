require 'json'
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

    def initialize(state_pieces = [])
        @save_state
        @status = "WHITE'S TURN"
        @selected = nil
        @current_player = "Black"
        setup_pieces(state_pieces)
        setup_board
    end
    
    def play
        # main_menu
        show_board
        until @status == "CHECKMATE"
            take_turn
        end
        @selected = nil
        show_board
        puts "                   #{@current_player.upcase} WINS!\n\n\n"
    end

    def get_piece(coords)
        @pieces.each do |piece|
            if piece.position == coords
                return piece
            end
        end
        nil
    end

    def main_menu
        system "clear"
        puts "Welcome to Chess, or Whatever."
        puts ""
        puts "Press ENTER to begin a new game."
        gets
    end
    
    def setup_pieces(state_pieces = [])
        @pieces = []
        
        if state_pieces.length == 0
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

        else
            #iterate over state_pieces, since it has pieces in it.
            @pieces = state_pieces

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

        puts "\n           COMMANDS:  LOAD  SAVE  QUIT"

        stat_len = 24-(@status.length/2)
        stat_line = ""
        stat_len.times { stat_line += " " }

        puts "\n#{stat_line}#{@status}\n\n"
    end
    
    def take_turn
        
        if @status == "INVALID MOVE"

            #load state from @save_state then reset it to "")
            from_json(@save_state)
            @save_state = ""

            @status = "Invalid Move -- CHECK!"
        elsif @status == "BACK"
            @status = "SELECT ANOTHER PIECE"
        elsif @status == "SAVE"
            @status = "GAME SAVED"
        elsif @status == "LOAD"
            @status = "GAME LOADED"
        elsif @status == "CHECK"
            @save_state = to_json()
            @status = @current_player == "White" ? "BLACK'S TURN -- CHECK!" : "WHITE'S TURN -- CHECK!"
            @current_player = @current_player == "White" ? "Black" : "White"
        else
            @save_state = to_json()
            @status = @current_player == "White" ? "BLACK'S TURN" : "WHITE'S TURN"
            @current_player = @current_player == "White" ? "Black" : "White"
        end
        
        @save_state = to_json #save state in case of invalid move

        @selected = nil
        choice = nil
        piece = nil
        destination = nil

        until piece.is_a?(Piece)
            show_board
            puts "#{@current_player}: Choose a Piece (A1 - H8)\n\n"
            choice = gets.chomp

            # look for keywords to bring up menu, save, or quit
            if choice.upcase == "LOAD"
                @status = "LOAD"
                load
                return 
            elsif choice.upcase == "SAVE"
                @status = "SAVE"
                save(to_json)
            elsif choice.upcase == "QUIT" || choice.upcase == "EXIT" || choice.upcase == "CLOSE"
                system "clear"
                exit
            end
            
            choice = validate_coords(choice)
            piece = get_piece(choice)
            if piece.is_a?(Piece)
                piece = nil if piece.player != @current_player
            end
        end

        piece.select

        until destination
            show_board
            puts "Where would you like to move the #{piece.name} (A1 - H8)\n\n"
            puts "Or type 'BACK' to select another piece\n\n"
            destination = gets.chomp
            if destination.upcase == "BACK"
                @status = "BACK"
                return 
            end
            destination = validate_coords(destination)
            destination = nil unless piece.moves.include?(destination)
        end

        if piece.name == "KING"
        end
        opponent = piece.move(destination)
        opponent.remove if opponent

        @selected = nil
        setup_board
        show_board

        #Check for Checkmate
        check_status = get_check()

        @status = check_status[0] == "CHECK" ? checkmate?(check_status[1], check_status[2]) : check_status[0] if check_status
    end
 
    def to_json
        pieces_str = []

        @pieces.each do |piece|
            piece_str = JSON.dump ({
                :name => piece.name,
                :position => piece.position,
                :player => piece.player
            })
            pieces_str << piece_str
        end
        JSON.dump ({
            :current_player => @current_player,
            :pieces => pieces_str
        })
    end

    def save(data)
        Dir.mkdir("save") unless Dir.exist?("save")
        puts "Please name your save file"
        filename = "save/#{gets.chomp}.json"
        File.open(filename, 'w') { |file| file.write(data) }
        print "File has been saved. Press ENTER to continue"
        gets
    end

    def from_json(str)
        new_pieces = []
        data = JSON.load str
        @current_player = data['current_player']
        data['pieces'].each do |piece|
            piece_str = JSON.load piece
            case piece_str['name']
            when "PAWN"
                new_pieces << Pawn.new(piece_str['position'], piece_str['player'], self)
            when "ROOK"
                new_pieces << Rook.new(piece_str['position'], piece_str['player'], self)
            when "KNIGHT"
                new_pieces << Knight.new(piece_str['position'], piece_str['player'], self)
            when "BISHOP"
                new_pieces << Bishop.new(piece_str['position'], piece_str['player'], self)
            when "QUEEN"
                new_pieces << Queen.new(piece_str['position'], piece_str['player'], self)
            when "KING"
                new_pieces << King.new(piece_str['position'], piece_str['player'], self)
            end
        end
        setup_pieces(new_pieces)
        setup_board
    end

    def load
        game_saves = Dir.entries('save').reject { |f| File.directory?(f) }.join("\n")
        puts 'Enter the game save name that you want to load from', "\nHere are all game saves\n"
        puts game_saves
        file_name = "save/#{gets.chomp}"
        puts 'Game save does not exist' unless File.exist?(file_name)
        exit unless File.exist?(file_name)
        from_json(File.read(file_name))
    end

    def get_check
        king = nil
        kingslayer = nil
        @pieces.each do |piece|
            owner = piece.player
            piece.select        # this will force each piece to update its valid moves array
            piece.moves.each do |move|
                target = get_piece(move)
                next if target == nil   # skip this element if it's empty
                if target.name == "KING"
                    if @current_player == target.player
                        return ["INVALID MOVE", target, piece]
                    else
                        king = target
                        kingslayer = piece
                    end
                end
            end
        end
        return ["CHECK", king, kingslayer] if kingslayer
    end

    def checkmate?(king, kingslayer)
        
        #see if moving the king would resolve check                             <--- if so, no checkmate
        temp_save = to_json
        king.moves.each do |possible_move|
            new_game = Game.new()
            new_game.from_json(temp_save)
            new_king = new_game.get_piece(king.position)
            new_king.move(possible_move)
            new_check_status = new_game.get_check
            return "CHECK" unless new_check_status
        end

        #see if capturing kingslayer would resolve check
        new_game = Game.new()
        new_game.from_json(temp_save)
        new_slayer = new_game.get_piece(kingslayer.position)
        new_slayer.remove
        new_check_status = new_game.get_check
        resolvable = new_check_status ? false : true

        #if it would, can any piece take opponent                           <--- if so, no checkmate
        player_pieces = @pieces.select { |piece| piece.player != @current_player }

        player_pieces.each do |potential_savior|
            return "CHECK" if potential_savior.moves.include?(kingslayer.position)
        end
            
        #get all blank spaces
        blank_spaces = []
        (0..7).to_a.each do |row|
            (0..7).to_a.each do |col|
                blank_spaces << [row, col] if get_piece([row, col]) == nil
            end
        end

        #put a pawn in each blank space and see if there's check
        resolvable = false
        blank_spaces.each do |blank|
            new_game = Game.new()
            new_game.from_json(temp_save)
            new_game.pieces << Pawn.new(blank, "White", new_game)
            new_check_status = new_game.get_check

            #if yes, can any piece move there?                                  <--- if so, no checkmate
            unless new_check_status
                player_pieces.each do |piece|
                    if piece.moves.include?(blank)
                        return "CHECK" unless piece.name == "KING"
                    end
                end
            end
        end
        
        "CHECKMATE"
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

end