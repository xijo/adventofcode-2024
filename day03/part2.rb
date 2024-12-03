#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/3

input = File.read('day03/input')
# input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

result = 0

input.split('do()').each do |doop|
  dopart, _dontpart = doop.split("don't()")
  result += dopart.scan(/mul\(\d{1,3},\d{1,3}\)/).map { _1.scan(/\d{1,3}/).map(&:to_i).reduce(:*) }.sum
end

puts result
