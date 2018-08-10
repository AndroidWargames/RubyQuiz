require_relative '../knight_traversal_tree.rb'

describe KnightTree do
  it 'should initiate tree' do
    knight_tree = KnightTree.new
    expect(knight_tree.squares.length).to eql(64)
  end

  it 'should exclude squares' do
    knight_tree = KnightTree.new(%w[a1 h3])
    expect(knight_tree.squares.length).to eql(62)
    expect(knight_tree.squares.include?('a1')).to be_falsy
    expect(knight_tree.squares.include?('h3')).to be_falsy
  end

  it 'should initialize neighbors of squares' do
    knight_tree = KnightTree.new(%w[a1 h3])
    square = knight_tree.square('d4')
    expect(square.neighbors.length).to eql(8)
    expect(square.neighbors[0].class).to eql(Integer)
  end

  describe '.square(square_name)' do
    it 'should return square object' do
      knight_tree = KnightTree.new(%w[a1 h3])
      expect(knight_tree.square('a2').class).to eql(Square)
    end
  end

  describe '.get_name' do
    it 'should return name of index' do
      knight_tree = KnightTree.new(%w[a1 h3])
      expect(knight_tree.get_name(0, 0)).to eql(nil)
      expect(knight_tree.get_name(0, 1)).to eql('a2')
      expect(knight_tree.get_name(-1, 0)).to eql(nil)
      expect(knight_tree.get_name(0, -1)).to eql(nil)
    end
  end

  describe '.get_neighbors' do
    it 'should get neighbors' do
      knight_tree = KnightTree.new(%w[a1 h3])
      b3_neighbors = %w[a5 c5 d4 d2 c1].sort
      expect(knight_tree.get_neighbors('b3').sort).to eql(b3_neighbors)
    end
  end

  describe '.get_path' do
    it 'should find shortest path' do
      knight_tree = KnightTree.new(%w[a1 h3])
      path = knight_tree.get_path('b3', 'c2')
      expect(path).to eql(%w[b3 d4 c2])
    end
  end
end

describe Square do
  it 'should intitialize square' do
    square = Square.new('a1', 3)
    expect(square.distance).to eql(100)
    expect(square.name).to eql('a1')
    expect(square.index).to eql(3)
  end
end

describe ChessBoard do
  describe '.letters' do
    it 'should return all letters' do
      expect(ChessBoard.letters).to eql(%w[a b c d e f g h])
    end
  end

  describe '.numbers' do
    it 'should return all numbers' do
      expect(ChessBoard.numbers).to eql(%w[1 2 3 4 5 6 7 8])
    end
  end

  describe '.all_squares' do
    it 'should return all square names' do
      squares = ChessBoard.all_squares
      expect(squares.length).to eql(64)
      expect(squares).to include('a1')
      expect(squares).to include('a8')
      expect(squares).to include('h3')
      expect(squares).to include('d7')
    end
  end

  describe '.square_name' do
    it 'should return name of index' do
      expect(ChessBoard.square_name(0, 0)).to eql('a1')
      expect(ChessBoard.square_name(0, 1)).to eql('a2')
      expect(ChessBoard.square_name(1, 0)).to eql('b1')
      expect(ChessBoard.square_name(-1, 0)).to eql(nil)
      expect(ChessBoard.square_name(0, -1)).to eql(nil)
    end
  end

  describe '.get_knight_neighbors' do
    it 'should get neighbors' do
      b3_neighbors = %w[a1 a5 c5 d4 d2 c1].sort
      actual_neighbors = ChessBoard.get_knight_neighbors('b3').sort
      expect(actual_neighbors).to eql(b3_neighbors)
    end
  end
end
