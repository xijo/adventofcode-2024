#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/6

require 'byebug'
require 'tty-progressbar'
require_relative '../lib/grid'

input = File.read('day06/input').lines.map(&:strip)
# input = File.read('day06/example').lines.map(&:strip)

def loop?(grid, start_x, start_y, obs_x, obs_y)
  return false if [start_x, start_y] == [obs_x, obs_y]

  original = grid[obs_x, obs_y]
  grid[obs_x, obs_y] = ?#

  direction = ?^
  rotations = { ?^ => ?>, ?> => ?v, ?v => ?<, ?< => ?^ }
  x, y = start_x, start_y
  visited = Set.new

  loop do
    state = [x, y, direction]
    # puts state.inspect
    return true if visited.include?(state)
    visited << state

    next_x, next_y = case direction
                     when ?^ then [x, y - 1]
                     when ?> then [x + 1, y]
                     when ?v then [x, y + 1]
                     when ?< then [x - 1, y]
                     end

    return false unless grid.contains?(next_x, next_y)

    if grid[next_x, next_y] == ?#
      direction = rotations[direction]
    else
      x, y = next_x, next_y
    end
  end
ensure
  grid[obs_x, obs_y] = original
end

grid = Grid.new
input.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
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

start_x, start_y = grid.positions(?^).first
bar = TTY::ProgressBar.new("checking positions [:bar] :current/:total :percent :eta", total: grid.marked.size, width: 60)
result = grid.marked.count do |(x, y), _c|
  bar.advance
  loop?(grid, start_x, start_y, x, y)
end

puts result
