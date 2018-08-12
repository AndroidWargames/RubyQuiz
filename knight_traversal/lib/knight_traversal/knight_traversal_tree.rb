# This builds a tree that uses DFS to find the shortest route for a knight
class KnightTree
  attr_accessor :squares
  attr_accessor :bad_squares

  def initialize(bad_squares = [])
    @squares = []
    @bad_squares = bad_squares
    @lookup = {}
    create_squares
    @queue = []
    @path = []
  end

  def get_path(start, finish)
    reset_distances
    start_square = square(start)
    start_square.distance = 0
    finish_square = square(finish)
    @queue << start_square.index
    breadth_first_search until @queue.empty?
    return nil if finish_square.distance == 100
    traverse_path(finish_square)
    @path
  end

  def reset_distances
    @squares.each do |square|
      square.distance = 100
    end
    @queue = []
  end

  def set_neighbors_for_all_squares
    @squares.each do |s|
      s.neighbors = get_neighbors(s.name).map { |n| @lookup[n] }
    end
  end

  def square(square_name)
    squares[@lookup[square_name]]
  end

  def get_neighbors(square_string)
    neighbors = ChessBoard.get_knight_neighbors(square_string)
    neighbors.reject { |n| @bad_squares.include?(n) }
  end

  def get_name(letter_index, number_index)
    square_name = ChessBoard.square_name(letter_index, number_index)
    bad_squares.include?(square_name) ? nil : square_name
  end

  private

  def create_squares
    ChessBoard.all_squares.each do |square_name|
      counter = @squares.length
      next if @bad_squares.include?(square_name)
      @squares << ChessSquare.new(square_name, counter)
      @lookup[square_name] = counter
    end
    set_neighbors_for_all_squares
  end

  def traverse_path(finish_square)
    current_square = finish_square
    @path = [finish_square.name]
    while current_square.distance > 0
      current_square.neighbors.each do |neighbor_index|
        current_square = find_next_node(neighbor_index, current_square)
      end
    end
  end

  def breadth_first_search
    current_square = squares[@queue[0]]
    current_square.neighbors.each do |neighbor_index|
      neighbor = @squares[neighbor_index]
      if neighbor.distance == 100
        neighbor.distance = current_square.distance + 1
        @queue << neighbor.index
      end
    end
    @queue.delete_at(0)
  end

  def find_next_node(neighbor_index, current_square)
    neighbor = @squares[neighbor_index]
    if neighbor.distance < current_square.distance
      current_square = neighbor
      @path.insert(0, current_square.name)
    end
    current_square
  end
end