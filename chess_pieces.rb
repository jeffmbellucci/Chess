require "./chess_board"
class Piece
  attr_reader :color, :type
  attr_accessor :pos
  TYPES = {
    :pawn => "P",
    :knight => "K",
    :rook => "R",
    :bishop => "B",
    :queen => "Q",
    :king => "K"
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
