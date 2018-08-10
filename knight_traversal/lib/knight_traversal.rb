module KnightTraversal
  class KnightCLI
    def self.get_path(start, finish, *bad_squares)
      tree = KnightTree.new (bad_squares)
      tree.get_path(start, finish)
    end
  end
end