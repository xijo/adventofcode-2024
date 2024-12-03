#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/1

input = File.read('day01/input').lines.map(&:strip)

first, second = input.map { |line| line.split('   ').map(&:to_i) }.transpose.map(&:sort)

result = 0
first.each_with_index { |f, i| result += (second[i] - f).abs }

puts "Total distance: #{result}"

result = 0
first.each { |f| result += second.count(f) * f }

puts "Similarity score: #{result.inspect}"
