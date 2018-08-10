# This builds a tree that uses DFS to find the shortest route for a knight
class KnightTree
  attr_accessor :squares
  attr_accessor :bad_squares

  def initialize(bad_squares = [])
    @squares = []
    @bad_squares = bad_squares
    @letters = 'abcdefgh'.chars
    @numbers = '12345678'.chars
    @lookup = {}
    create_squares
    @queue = []
  end

  def create_squares
    counter = 0
    letters.each do |letter|
      numbers.each do |number|
        square_name = letter + number
        next if @bad_squares.include?(square_name)
        @squares << Square.new(square_name, counter)
        @lookup[square_name] = counter
        counter += 1
      end
    end
    get_neighbors_for_all_squares
  end

  def get_path(start, finish)
    reset_distances
    start_square = square(start)
    start_square.distance = 0
    finish_square = square(finish)
    @queue << start_square.index
    breadth_first_search until @queue.empty?
    traverse_path(finish_square)
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

  def traverse_path(finish_square)
    return nil if finish_square.distance == 100
    current_square = finish_square
    path = [finish_square.name]
    while current_square.distance > 0
      current_square.neighbors.each do |neighbor_index|
        neighbor = @squares[neighbor_index]
        if neighbor.distance < current_square.distance
          path += [neighbor.name]
          current_square = neighbor
          next
        end
      end
    end
    path.reverse
  end

  def reset_distances
    @squares.each do |square|
      square.distance = 100
    end
    @queue = []
  end

  def get_neighbors_for_all_squares
    @squares.each do |new_square|
      new_square.neighbors = get_neighbors(new_square.name).map { |n| @lookup[n] }
    end
  end

  def square(square_name)
    squares[@lookup[square_name]]
  end

  def get_neighbors(square_string)
    neighbors = []
    letter, number = get_coordinates(square_string)
    [-2, -1, 1, 2].each do |delta_letter|
      [delta_letter.abs - 3, 3 - delta_letter.abs].each do |delta_number|
        new_name = get_name(letter + delta_letter, number + delta_number)
        neighbors << new_name if new_name
      end
    end
    neighbors
  end

  def get_coordinates(square_string)
    [@letters.index(square_string[0]),
     @numbers.index(square_string[1])]
  end

  # returns name of square if it is on the board and not a bad square
  def get_name(letter_index, number_index)
    if (0..7).cover?(letter_index) && (0..7).cover?(number_index)
      square_name = letters[letter_index] + numbers[number_index]
      return bad_squares.include?(square_name) ? nil : square_name
    end
    nil
  end

  private

  attr_accessor :letters
  attr_accessor :numbers
end

# represents state of a square for the path of a KnightTree
class Square
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
