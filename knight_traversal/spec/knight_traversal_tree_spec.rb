RSpec.describe "KnightTree" do
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
      expect(knight_tree.square('a2').class).to eql(ChessSquare)
    end
  end

  describe 'reset_distances' do
    it 'should return all square distances to 100' do
      knight_tree = KnightTree.new(%w[a1 h3])
      knight_tree.reset_distances
      knight_tree.squares.each do |square|
        expect(square.distance).to eql(100)
      end
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