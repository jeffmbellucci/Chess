#encoding: UTF-8
require "./chess_board"
require 'colorize'


class Piece
  attr_reader :color, :type
  attr_accessor :pos
  TYPES = {
    :pawn => "♟",
    :knight => "♞",
    :rook => "♜",
    :bishop => "♝",
    :queen => "♚",
    :king => "♛"
  }
  def initialize(pos, color, type)
    @pos = pos
    @color = color.to_sym
    @type = type
  end

  def update_position(pos)
    @pos = pos
    @pos
  end

  def to_s
    TYPES[@type].colorize(@color)
  end
end

class Bishop < Piece
  def initialize(pos, color)
    super(pos, color, :bishop)
  end

  def move(end_pos)
    #check for valid bishop move
    # raise error if invalid
  end
end

class King < Piece
  def initialize(pos, color)
    super(pos, color, :king)
  end

  def move(end_pos)
    #check for valid bishop move
    # raise error if invalid
  end
end

class Knight < Piece
  def initialize(pos, color)
    super(pos, color, :knight)
  end

  def move(end_pos)
    #check for valid bishop move
    # raise error if invalid
  end
end

class Pawn < Piece
  def initialize(pos, color)
    super(pos, color, :pawn)
  end

  def move(end_pos)
    #check for valid bishop move
    # raise error if invalid
  end
end

class Queen < Piece
  def initialize(pos, color)
    super(pos, color, :queen)
  end

  def move(end_pos)
    #check for valid bishop move
    # raise error if invalid
  end
end

class Rook < Piece
  def initialize(pos, color)
    super(pos, color, :rook)
  end

  def move(end_pos)
    #check for valid bishop move
    # raise error if invalid
  end
end