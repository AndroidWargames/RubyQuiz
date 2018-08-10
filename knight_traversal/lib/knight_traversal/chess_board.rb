# converts 'a1' style notation and gets neigh-bors
class ChessBoard
  def self.get_coordinates(square_string)
    [letters.index(square_string[0]),
     numbers.index(square_string[1])]
  end

  def self.square_name(letter_index, number_index)
    if (0..7).cover?(letter_index) && (0..7).cover?(number_index)
      return letters[letter_index] + numbers[number_index]
    end
    nil
  end

  def self.get_knight_neighbors(square_string)
    neighbors = []
    letter, number = get_coordinates(square_string)
    [-2, -1, 1, 2].each do |delta_letter|
      [delta_letter.abs - 3, 3 - delta_letter.abs].each do |delta_number|
        new_name = square_name(letter + delta_letter, number + delta_number)
        neighbors << new_name if new_name
      end
    end
    neighbors
  end

  def self.all_squares
    letters.product(numbers).map { |x| x[0] + x[1] }
  end

  def self.letters
    'abcdefgh'.chars
  end

  def self.numbers
    '12345678'.chars
  end
end