require 'thor'
require_relative '../knight_traversal'
module KnightTraversal
  class CLI < Thor
    desc "get_path START, FINISH", "gets knight's path"
    def get_path(start, finish, *bad_squares)
      puts KnightTraversal::KnightCLI.get_path(start, finish, *bad_squares).to_s
    end
  end
end