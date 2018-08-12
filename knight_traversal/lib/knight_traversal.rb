require "knight_traversal/version"
require "knight_traversal/knight_traversal_tree"
require "knight_traversal/chess_square"
require "knight_traversal/chess_board"

module KnightTraversal
  class KnightCLI
    def self.get_path(start, finish, *bad_squares)
      tree = KnightTree.new (bad_squares)
      tree.get_path(start, finish)
    end
  end
end