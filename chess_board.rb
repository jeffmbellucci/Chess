require  "./chess_pieces"
require "colorize"

class Board
  def initialize
    @board = []
    8.times do
      row = []
      8.times { row << "nil" }
      @board << row
    end
    populate_board
  end

  def populate_board
    #fills board with starting pieces
  end

  def to_s
    string = "  "
    ("A".."H").each{|letter| string << "#{letter} "}
    string << "\n"
    @board.each_with_index do |row, i|
      string << "#{i} "
      row.each do |square|
        if square.nil?
          string << square.to_s + " "
        else
          string << "_ "
        end
      end
      string << "\n"
    end
    string
  end

  def move_piece
    #gets piece to move from user via command line
    #calls piece specific move
    #which uses Piece class move method to update pieces location
    #re-display board with updated positions
  end
end

