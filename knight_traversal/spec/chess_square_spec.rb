RSpec.describe "Square" do
  it 'should intitialize square' do
    square = ChessSquare.new('a1', 3)
    expect(square.distance).to eql(100)
    expect(square.name).to eql('a1')
    expect(square.index).to eql(3)
  end
end