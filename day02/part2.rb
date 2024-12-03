#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/2

require 'byebug'
input = File.read('day02/input').lines.map(&:strip).map { _1.split(' ').map(&:to_i) }
# input = File.read('day02/example').lines.map(&:strip).map { _1.split(' ').map(&:to_i) }

def safe?(line)
  (line.sort == line || line.sort.reverse == line) &&
    line.uniq.size == line.size &&
    line.each_cons(2).all? { |a, b| (a - b).abs <= 3 }
end

safe = input.each.count do |line|
  if safe?(line)
    true
  else
    line.each_with_index.any? do |_, i|
      smaller_line = line.dup
      smaller_line.delete_at(i)
      safe?(smaller_line)
    end
  end
end

puts "Safe lines: #{safe}"
