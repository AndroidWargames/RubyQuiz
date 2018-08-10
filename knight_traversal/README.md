# KnightTraversal

## Description

This gem finds a shortest path travelled by a knight between two squares on a chessboard. It also accepts additional arguments to make certain squares off-limits. It implements a basic breadth-first search algorithm.

## Installation

you can download the package file and install it from your local directory with the following:

    $ gem install knight_traversal

## Usage

simply run this command

    $ knight_traversal get_path <args>

and it will return a list of square names indicating the path. If there is no valid path, it will return nothing.

### Arguments

First argument: the square which the path will start from
Second argument: the square the knight will try to reach
Additional arguments: squares that are prohibited

### Formatting

all arguments should be formatted of a letter a-h followed by a number 1-8

examples: 'a3' 'h5' 'e1' 'c8'

invalid examples: 'a0' 'f1000' 'ff' '90' 'a' '3' ''

### Examples

    $ knight_traversal get_path a1 b1
    > ["a1", "c2", "a3", "b1"]

    $ knight_traversal get_path a1 b1 c2 d2
    > ["a1", "b3", "d4", "b5", "a3", "b1"]

    $ knight_traversal get_path a1 d4 c2 b3
    > 

## Contributing

Please don't contribute. This was simply done as an exercise and has no real purpose for now, probably ever.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
