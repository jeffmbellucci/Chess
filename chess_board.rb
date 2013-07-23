require  "./chess_pieces"
require "colorize"

class Board
  def initialize
    @board = []
    8.times do
      row = []
      8.times { row << nil }
      @board << row
    end
    populate_board
  end

  def populate_board
    [0,  7].each do |i|
      @board[i][0] = Rook.new([0,0], i.zero? ? :blue : :red)
      @board[i][1] = Knight.new([0,1], i.zero? ? :blue : :red)
      @board[i][2] = Bishop.new([0,2], i.zero? ? :blue : :red)
      @board[i][3] = King.new([0,3], i.zero? ? :blue : :red)
      @board[i][4] = Queen.new([0,4], i.zero? ? :blue : :red)
      @board[i][5] = Bishop.new([0,5], i.zero? ? :blue : :red)
      @board[i][6] = Knight.new([0,6], i.zero? ? :blue : :red)
      @board[i][7] = Rook.new([0,7], i.zero? ? :blue : :red)
    end
    [1, 6].each do |i|
      8.times do |j|
        @board[i][j] = Pawn.new([i,j], i == 1 ? :blue : :red)
      end
    end

  end

  def to_s
    string = "  "
    ("A".."H").each{|letter| string << "#{letter} "}
    string << "\n"
    @board.each_with_index do |row, i|
      string << "#{i} "
      row.each_with_index do |square, j|
        if !square.nil?
          string << square.to_s   + ' '
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
    from_pos, to_pos = get_user_move
    x, y = from_pos
    if @board[x][y].valid_move?(to_pos)
      @board[x][y].update_position(to_pos)
      i, j = to_pos
      @board[i][j], @board[x][y] = @board[x][y], nil
    else
      move_piece
    end
    #gets piece to move from user via command line
    #calls piece specific move
    #which uses Piece class move method to update pieces location
    #re-display board with updated positions
  end

  def get_user_move
    puts "Which piece do you want to move?"
    input = gets.chomp
    #interpret input here
    puts "Where should it go?"
    input = gets.chomp
    #interpret input here
    [from_coord, to_coord]
  end

end

