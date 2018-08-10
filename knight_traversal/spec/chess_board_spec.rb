RSpec.describe "ChessBoard" do
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