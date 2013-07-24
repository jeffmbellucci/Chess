load  "./chess_pieces.rb"
require "colorize"

class Board
  def initialize
    @board = Board.create_empty_board
    populate_board
    @current_color = :white
    @turns = 0
  end

  def self.create_empty_board
    board = []
    8.times do
      row = []
      8.times { row << nil }
      board << row
    end
    board
  end

  def dup
    new_board = Board.create_empty_board
    @board.each_with_index do |row, i|
      row.each_with_index do |piece, j|
          new_board = piece.class.new(piece.color, [i, j]) if @board[i][j]
      end
    end
    new_board
  end

  def populate_board
    [0, 7].each do |i|
      @board[i][0] = Rook.new([i,0], i.zero? ? :black : :white)
      @board[i][1] = Knight.new([i,1], i.zero? ? :black : :white)
      @board[i][2] = Bishop.new([i,2], i.zero? ? :black : :white)
      @board[i][3] = King.new([i,3], i.zero? ? :black : :white)
      @board[i][4] = Queen.new([i,4], i.zero? ? :black : :white)
      @board[i][5] = Bishop.new([i,5], i.zero? ? :black : :white)
      @board[i][6] = Knight.new([i,6], i.zero? ? :black : :white)
      @board[i][7] = Rook.new([i,7], i.zero? ? :black : :white)
    end
    [1, 6].each do |i|
      8.times do |j|
        @board[i][j] = Pawn.new([i,j], i == 1 ? :black : :white)
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
          string << square.to_s
        else
          string << ("  ").colorize(:background => back_ground(i, j))
        end
      end
      string << "\n"
    end
    string
  end

  def back_ground(i, j)
    ((i + j) % 2 == 1 ? :blue : :light_blue)
  end

  def turn
    from_pos, to_pos = get_user_move
    x, y = from_pos
    if taking_own_piece?(to_pos)
      puts "You can't take your own piece"
      turn
    elsif check?(@current_color, move(from_pos, to_pos))
      puts "Don't put yourself in check"
      turn
    elsif @board[x][y].valid_move?(to_pos, @board)
      move!(from_pos, to_pos)
    else
      puts "That's not a valid move."
      turn
    end
  end

  def taking_own_piece?(to_pos)
    x, y = to_pos
    !@board[x][y].nil? && @board[x][y].color == @current_color
  end

  def grabbed_invalid_piece?(from_pos)
    p from_pos
    x, y = from_pos
    @board[x][y].nil? || @board[x][y].color != @current_color
  end

  def move(from_pos, to_pos)
    temp_board = dup
    x, y = from_pos
    temp_board[x][y].update_position(to_pos)
    i, j = to_pos
    temp_board[i][j], temp_board[x][y] = temp_board[x][y], nil
    temp_board
  end

  def move!(from_pos, to_pos)
    x, y = from_pos
    @board[x][y].update_position(to_pos)
    i, j = to_pos
    @board[i][j], @board[x][y] = @board[x][y], nil
  end

  def get_user_move
    begin
      puts "Which piece do you want to move? (letter number)"
      user_input = gets.chomp.split(" ").join('')
      from_coord = interpret_input(user_input)
      raise "Chose incorrectly" if grabbed_invalid_piece?(from_coord)
    rescue
      puts "You chose, poorly."
      retry
    end
     puts "It can go: #{@board[from_coord.first][from_coord.last].all_moves(@board)}"
    begin

      puts "Where should it go?(letter number)"
      #remove after test
      to_coord = interpret_input(gets.chomp.split(" ").join(''))
    rescue
      puts "That's not a coordinate"
      retry
    end
    [from_coord, to_coord]
  end

  def interpret_input(string)
    split_string = string.downcase.split("")

    output = [split_string.last.to_i, split_string.first.ord - 97]
    raise "Invalid Input" if string.length != 2 ||
            output.first > 7 || output.last > 7
    output
  end

  def play_chess
    @current_color = :white
    until game_won?
      puts self
      puts "#{@current_color.capitalize}'s turn:"
      turn
      @current_color = @current_color == :white ? :black : :white
      @turns += 1
    end
  end

  def game_won?
    if check?(@current_color)
      if check_mate?(@current_color)
        puts "Game over, #{@current_color} loses"
        return true
      else
        puts "#{@current_color.capitalize}: You're in check"
      end
    end
    false
    @turns > 10
  end
end

def check?(color, board)
  false
end

