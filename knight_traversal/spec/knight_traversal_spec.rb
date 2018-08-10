

RSpec.describe KnightTraversal::KnightCLI do
  it "has a version number" do
    expect(KnightTraversal::VERSION).not_to be nil
  end

  describe KnightTraversal::KnightCLI do
    it ".get_path should return something" do
      expect(KnightTraversal::KnightCLI.get_path("a1", "c2")).to eql(["a1", "c2"])
    end
  end
end
