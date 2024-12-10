#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/10

require_relative '../lib/grid'

input = File.read('day10/input').lines.map(&:strip)
# input = File.read('day10/example').lines.map(&:strip)

grid = Grid.new
input.each_with_index do |line, y|
  line.strip.chars.each_with_index do |height, x|
    grid[x, y] = height.to_i
  end
end

def path_count(grid, x, y, visited = Set.new)
  return 1 if grid[x, y] == 9

  current_height = grid[x, y]
  paths = 0

  grid.adjacent(x, y).each do |new_x, new_y|
    next if visited.include?([new_x, new_y])
    next unless grid[new_x, new_y] == current_height + 1

    paths += path_count(grid, new_x, new_y, visited.dup.merge(Set[[x, y]]))
  end

  paths
end

result = grid.positions(0).map { |x, y| path_count(grid, x, y) }.sum

puts result
