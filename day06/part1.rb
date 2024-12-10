#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/6

require 'byebug'
require_relative '../lib/grid'

input = File.read('day06/input').lines.map(&:strip)
# input = File.read('day06/example').lines.map(&:strip)
grid = Grid.new

input.each_with_index do |line, y|
  line.strip.chars.each_with_index do |char, x|
    grid[x, y] = char
  end
end

direction = ?^
rotations = { ?^ => ?>, ?> => ?v, ?v => ?<, ?< => ?^ }
x, y = grid.positions(?^).first

loop do
  break unless grid.contains?(x, y)
  grid.mark(x, y)
  next_x, next_y = case direction
                   when ?^ then [x, y - 1]
                   when ?> then [x + 1, y]
                   when ?v then [x, y + 1]
                   when ?< then [x - 1, y]
                   end

  if grid[next_x, next_y] == ?#
    direction = rotations[direction]
  else
    x, y = next_x, next_y
  end
end

puts grid.marked.inspect
puts grid.marked.size
