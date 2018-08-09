class SquareFiller
  def initialize(size)
    @base = size
    @size = 2 ** size
    @grid = Array.new(@size) { Array.new(@size, -1) }
  end

  def base
    @base
  end

  def size
    @size
  end

  def grid
    @grid
  end

  def random_fill()
    fill(rand(size ** 2))
    print_grid
  end

  def fill(int_location, starting_value=1)
    if size == 2
      @grid = @grid.map {|x| x.map {|y| starting_value} }
      x, y = locate_tile_from_int(int_location)
      @grid[x][y] = 0
    else
      recursive_fill(int_location, starting_value)
    end
    @grid
  end

  def recursive_fill(int_location, starting_value)
    lesser_quadrant = quadrant(int_location)
    counter = starting_value
    for i in 0..3
      if i == lesser_quadrant
        filler = SquareFiller.new(@base - 1)
        filler.fill(convert_to_quadrant_location(int_location), counter)
        copy(filler, i)
        counter += filler.size ** 2 / 3
      else
        filler = SquareFiller.new(@base - 1)
        filler.fill(filler.empty_corner(i), counter)
        copy(filler, i)
        counter += filler.size ** 2 / 3
      end
    end

    for i in 0..3
      if i != lesser_quadrant
        x, y = center_square(i)
        @grid[x][y] = counter
      end
    end
    counter += 1
    @grid
  end

  def locate_tile_from_int(int)
    return [int % @size, int / @size]
  end

  def quadrant(int)
    x, y = locate_tile_from_int(int)
    quad = 0
    if x >= @size / 2
      quad += 1
    end
    if y >= @size / 2
      quad += 2
    end
    quad
  end

  def copy(small_filler, quadrant)
    count = small_filler.grid.length
    x_offset = quadrant % 2 == 1 ? count : 0
    y_offset = quadrant >= 2 ? count : 0
    for x in 0..count - 1
      for y in 0..count - 1

        @grid[x + x_offset][y + y_offset] = small_filler.grid[x][y]
      end
    end
  end

  def empty_corner(quad)
    case quad
    when 0
      return @size ** 2 - 1
    when 1
      return @size ** 2 - @size
    when 2
      return @size - 1
    when 3
      return 0
    end
  end

  def convert_to_quadrant_location(location)
    small_size = size / 2
    new_location = location % small_size
    new_column = (location / size) % small_size
    new_location += new_column * small_size
    new_location
  end

  def center_square(quad)
    n = @size / 2
    case quad
    when 0
      return [n - 1, n - 1]
    when 1
      return [n, n - 1]
    when 2
      return [n - 1, n]
    when 3
      return [n, n]
    end
  end

  def print_grid
    x = 0
    y = 0
    w = @grid.length
    h = @grid[0].length
    print w, h
    top_and_bottom = "+-" * size + "+\n"
    output_string = "\n" + top_and_bottom
    while x < w * 2 - 1 do

      if x % 2 == 1
        output_string += "+"
      
        while y < h do
          if @grid[x / 2][y] == @grid[x/2 + 1][y]
            output_string += " +"
          else
            output_string += "-+"
          end

          y += 1
        end
      else
        output_string += "|"
        while y < h do
          filler = @grid[x / 2][y] == 0 ? "X" : " "
          if @grid[x / 2][y] == @grid[x/2][y + 1]
            output_string += filler + " "
          else
            output_string += filler + "|"
          end
          y += 1
        end
      end

      output_string += "\n"
      y = 0
      x += 1
    end

    print(output_string + top_and_bottom)
  end
end