# represents state of a square for the path of a KnightTree
class ChessSquare
  attr_accessor :name
  attr_accessor :index
  attr_accessor :distance
  attr_accessor :neighbors

  def initialize(name, index)
    @name = name
    @index = index
    @distance = 100
  end
end