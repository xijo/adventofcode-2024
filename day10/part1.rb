#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/10

require_relative '../lib/grid'

input = File.read('day10/input').lines.map(&:strip)
# input = File.read('day10/example').lines.map(&:strip)

grid = Grid.new
input.each_with_index do |line, y|
  line.chars.each_with_index do |height, x|
    grid[x, y] = height.to_i
  end
end

def path_count(grid, x, y)
  reachable_nines = Set.new
  path = [[x, y]]
  visited = Set.new([[x, y]])

  while !path.empty?
    x, y = path.last
    current_height = grid[x, y]

    found_next = false
    grid.adjacent(x, y).each do |new_x, new_y|
      next if visited.include?([new_x, new_y])

      if grid[new_x, new_y] == current_height + 1
        if grid[new_x, new_y] == 9
          reachable_nines << [new_x, new_y]
        else
          path << [new_x, new_y]
          visited << [new_x, new_y]
          found_next = true
          break
        end
      end
    end

    path.pop unless found_next
  end

  reachable_nines.size
end

result = grid.positions(0).map { |x, y| path_count(grid, x, y) }.sum

puts result
