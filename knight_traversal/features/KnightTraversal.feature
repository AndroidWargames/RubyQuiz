Feature: Correct Traversal
  As a CLI
  I want to return correct path

  Scenario: ordinary traverse
    When I run `knight_traversal get_path "b3" "a1" `
    Then the output should contain "a1"

  Scenario: blocked traverse
    When I run `knight_traversal get_path "b3" "c2" "a1"`
    Then the output should contain "d4"

  Scenario: no path
    When I run `knight_traversal get_path "a1" "d4" "b3" "c2"`
    Then the output should contain ""
