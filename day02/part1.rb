#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/2

require 'byebug'
input = File.read('day02/input').lines.map(&:strip)
# input = File.read('day02/example').lines.map(&:strip)

safe = input.each.count do |line|
  numbers = line.split(' ').map(&:to_i)
  (numbers.sort == numbers || numbers.sort.reverse == numbers) &&
    numbers.uniq.size == numbers.size &&
    numbers.each_cons(2).all? { |a, b| (a - b).abs <= 3 }
end

puts "Safe lines: #{safe}"
