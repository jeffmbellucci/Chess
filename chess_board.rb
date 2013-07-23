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
      row.each_with_index do |square, j|
        if square.nil?
          string << (square.to_s + " ").colorize(:background => back_ground(i, j))
        else
          string << ("  ").colorize(:background => back_ground(i, j))
        end
      end
      string << "\n"
    end
    string
  end

  def back_ground(i, j)
    ((i + j) % 2 == 1 ? :black : :white)
  end

  def move_piece
    #gets piece to move from user via command line
    #calls piece specific move
    #which uses Piece class move method to update pieces location
    #re-display board with updated positions
  end
end

