require_relative '../square_filler.rb'

describe SquareFiller do

  it "should initialize size" do
    squareFiller1 = SquareFiller.new(1)
    expect(squareFiller1.size).to eql(2)
    squareFiller2 = SquareFiller.new(2)
    expect(squareFiller2.size).to eql(4)
    squareFiller2 = SquareFiller.new(3)
    expect(squareFiller2.size).to eql(8)
  end

  it "should initialize base" do
    squareFiller1 = SquareFiller.new(1)
    expect(squareFiller1.base).to eql(1)
    squareFiller2 = SquareFiller.new(2)
    expect(squareFiller2.base).to eql(2)
  end

  it "should initialize grid" do
    squareFiller1 = SquareFiller.new(1)
    expect(squareFiller1.grid).to eql([[-1, -1], [-1, -1]])
    squareFiller2 = SquareFiller.new(2)
    expect(squareFiller2.grid).to eql([[-1, -1, -1, -1], 
                                       [-1, -1, -1, -1], 
                                       [-1, -1, -1, -1], 
                                       [-1, -1, -1, -1]])
  end

  describe ".locate_tile_from_int" do
    it "should return x, y coordinates to a square" do
      squareFiller2 = SquareFiller.new(2)
      expect(squareFiller2.locate_tile_from_int(0)).to eql([0, 0])
      expect(squareFiller2.locate_tile_from_int(14)).to eql([2, 3])
      expect(squareFiller2.locate_tile_from_int(9)).to eql([1, 2])
    end
  end

  describe ".fill" do
    it "should fill 2x2 square given a blank location" do      
      squareFiller1 = SquareFiller.new(1)
      expect(squareFiller1.fill(1)).to eql([[1, 1], [0, 1]])
    end

    it "should fill starting at specified integer" do
      squareFiller1 = SquareFiller.new(1)
      expect(squareFiller1.fill(1, 3)).to eql([[3, 3], [0, 3]])
    end

    it "should fill 4x4 square given a blank location" do
      squareFiller2 = SquareFiller.new(2)
      expect(squareFiller2.fill(9)).to eql([[1, 1, 3, 3], 
                                           [1, 5, 0, 3], 
                                           [2, 5, 5, 4], 
                                           [2, 2, 4, 4]])
    end
  end

  describe ".quadrant" do
    it "should determine which quadrant a square is in" do
      squareFiller2 = SquareFiller.new(2)
      expect(squareFiller2.quadrant(0)).to eql(0)
      expect(squareFiller2.quadrant(3)).to eql(1)
      expect(squareFiller2.quadrant(14)).to eql(3)

      squareFiller4 = SquareFiller.new(4)
      expect(squareFiller4.quadrant(14)).to eql(1)
      expect(squareFiller4.quadrant(240)).to eql(2)
    end
  end

  describe ".copy" do
    it "should copy a smaller squarefiller into a quadrant" do
      squareFiller1 = SquareFiller.new(1)
      squareFiller1.fill(1)
      squareFiller2 = SquareFiller.new(2)
      squareFiller2.copy(squareFiller1, 2)
      expect(squareFiller2.grid).to eql([[-1, -1, 1, 1], 
                                           [-1, -1, 0, 1], 
                                           [-1, -1, -1, -1], 
                                           [-1, -1, -1, -1]])
    end
  end 

  describe ".empty_corner" do
    it "should return corner of opposite quadrant" do
      squareFiller2 = SquareFiller.new(2)
      expect(squareFiller2.empty_corner(0)).to eql(15)
      expect(squareFiller2.empty_corner(2)).to eql(3)
      expect(squareFiller2.empty_corner(1)).to eql(12)
      expect(squareFiller2.empty_corner(3)).to eql(0)

      squareFiller4 = SquareFiller.new(4)
      expect(squareFiller4.empty_corner(0)).to eql(255)
      expect(squareFiller4.empty_corner(2)).to eql(15)
      expect(squareFiller4.empty_corner(1)).to eql(240)
      expect(squareFiller4.empty_corner(3)).to eql(0)
    end
  end

  describe ".convert_to_quadrant_location" do
    it "should return location relative to quadrant size" do
      squareFiller2 = SquareFiller.new(2)
      expect(squareFiller2.convert_to_quadrant_location(15)).to eql(3)
      expect(squareFiller2.convert_to_quadrant_location(9)).to eql(1)
      expect(squareFiller2.convert_to_quadrant_location(12)).to eql(2)
      expect(squareFiller2.convert_to_quadrant_location(13)).to eql(3)

      squareFiller3 = SquareFiller.new(3)
      expect(squareFiller3.convert_to_quadrant_location(63)).to eql(15)
      expect(squareFiller3.convert_to_quadrant_location(60)).to eql(12)
      expect(squareFiller3.convert_to_quadrant_location(59)).to eql(15)
      expect(squareFiller3.convert_to_quadrant_location(7)).to eql(3)
    end
  end

  describe ".center_square" do
    it "should innermost square of quadrant" do
      squareFiller2 = SquareFiller.new(2)
      expect(squareFiller2.center_square(0)).to eql([1, 1])
      expect(squareFiller2.center_square(1)).to eql([2, 1])
      expect(squareFiller2.center_square(2)).to eql([1, 2])
      expect(squareFiller2.center_square(3)).to eql([2, 2])

      squareFiller3 = SquareFiller.new(3)
      expect(squareFiller3.center_square(0)).to eql([3, 3])
      expect(squareFiller3.center_square(1)).to eql([4, 3])
      expect(squareFiller3.center_square(2)).to eql([3, 4])
      expect(squareFiller3.center_square(3)).to eql([4, 4])
    end
  end


end