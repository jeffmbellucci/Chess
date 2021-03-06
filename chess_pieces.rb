#encoding: UTF-8
require "./chess_board"
require 'colorize'


class Piece
  attr_reader :color, :type
  attr_accessor :pos
  TYPES = {
    :Pawn => "♟",
    :Knight => "♞",
    :Rook => "♜",
    :Bishop => "♝",
    :Queen => "♛",
    :King => "♚"
  }
  def initialize(pos, color)
    @pos = pos
    @color = color.to_sym

  end

  def update_position(pos)
    @pos = pos
    @pos
  end

  def to_s
    type = self.class.to_s.to_sym
    "  #{TYPES[type]}   ".colorize(:color => @color.to_sym, :background => back_ground(@pos))
  end

  def all_moves(board)
    array_of_moves = []
    8.times do |i|
      8.times do |j|
        if board[i][j].nil?
          array_of_moves << [i, j] if valid_move?([i, j], board)
        else
          array_of_moves << [i, j] if color != board[i][j].color &&
                                    valid_move?([i, j], board)
        end
      end
    end
    array_of_moves
  end

  private
  def back_ground(pos)
    i, j = pos
    ((i + j) % 2 == 1 ? :blue : :light_blue)
  end
end

class Bishop < Piece
  def initialize(pos, color)
    super(pos, color)
  end

  def valid_move?(end_pos, board)
    delta_x = (end_pos.first - @pos.first)
    delta_y = (end_pos.last - @pos.last)
    return false if delta_x.abs != delta_y.abs

    sign_x = delta_x / delta_x.abs
    sign_y = delta_y / delta_y.abs

    pos = [@pos[0] + sign_x, @pos[1] + sign_y]
    until pos == end_pos
      return false unless board[pos[0]][pos[1]].nil?
      pos = [pos[0] + sign_x, pos[1] + sign_y]
    end
    true
  end


end

class King < Piece
  def initialize(pos, color)
    super(pos, color)
  end

  def valid_move?(end_pos, board)
    delta_x = (end_pos.first - @pos.first).abs
    delta_y = (end_pos.last - @pos.last).abs
    return false if delta_x > 1 || delta_y > 1
    true
  end
end

class Knight < Piece
  def initialize(pos, color)
    super(pos, color)
  end

  def valid_move?(end_pos, board)
    delta_x = (end_pos.first - @pos.first).abs
    delta_y = (end_pos.last - @pos.last).abs
    (delta_x == 2 && delta_y == 1) || (delta_x == 1 && delta_y == 2)
  end
end

class Pawn < Piece
  def initialize(pos, color)
    super(pos, color)
  end

  def valid_move?(end_pos, board)
    delta_y = (end_pos.first - @pos.first)
    delta_x = (end_pos.last - @pos.last)
    if color == :white
      return false if delta_y >= 0
      return true if @pos.first == 6 && delta_y == -2 && delta_x == 0 &&
                    board[end_pos[0]][end_pos[1]].nil?
    else
      return false if delta_y <= 0
      return true if @pos.first == 1 && delta_y == 2 && delta_x == 0 &&
                    board[end_pos[0]][end_pos[1]].nil?
    end
    return false if delta_x != 0 && board[end_pos[0]][end_pos[1]].nil?
    return false if delta_x.abs > 1 || delta_y.abs > 1
    return false if delta_x == 0 && !board[end_pos[0]][end_pos[1]].nil?
    true
  end
end

class Queen < Piece
  def initialize(pos, color)
    super(pos, color)
  end

  def valid_move?(end_pos, board)
    delta_x = (end_pos.first - @pos.first)
    delta_y = (end_pos.last - @pos.last)
    return false unless delta_x.abs == delta_y.abs ||
                  (delta_x.zero? && !delta_y.zero?) ||
                   (!delta_x.zero? && delta_y.zero?)
    delta_x == 0 ? sign_x = 0 : sign_x = delta_x / delta_x.abs
    delta_y == 0 ? sign_y = 0 : sign_y = delta_y / delta_y.abs

    pos = [@pos[0] + sign_x, @pos[1] + sign_y]
    until pos == end_pos
      return false unless board[pos[0]][pos[1]].nil?
      pos = [pos[0] + sign_x, pos[1] + sign_y]
    end
    true
  end
end

class Rook < Piece
  def initialize(pos, color)
    super(pos, color)
  end

  def valid_move?(end_pos, board)
    delta_x = (end_pos.first - @pos.first)
    delta_y = (end_pos.last - @pos.last)
    return false unless (delta_x.zero? && !delta_y.zero?) ||
                   (!delta_x.zero? && delta_y.zero?)

    delta_x == 0 ? sign_x = 0 : sign_x = delta_x/delta_x.abs
    delta_y == 0 ? sign_y = 0 : sign_y = delta_y/delta_y.abs

    pos = [@pos[0] + sign_x, @pos[1] + sign_y]
    until pos == end_pos
      return false unless board[pos[0]][pos[1]].nil?
      pos = [pos[0] + sign_x, pos[1] + sign_y]
    end
    true
  end
end