require 'thor'
require_relative '../knight_traversal'
module KnightTraversal
  class CLI < Thor
    desc "get_path START, FINISH", "gets knight's path"
    long_desc = File.read(__dir__ + '/cli_long_description.txt')
    def get_path(start, finish, *bad_squares)
      puts KnightTraversal::KnightCLI.get_path(start, finish, *bad_squares).to_s
    end

    desc "help", "gets help"
    def help
      puts File.read(__dir__ + '/cli_long_description.txt')
    end
    default_task :help
  end
end