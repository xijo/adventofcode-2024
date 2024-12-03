#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/3

input = File.read('day03/input')

puts input.scan(/mul\(\d{1,3},\d{1,3}\)/).map { _1.scan(/\d{1,3}/).map(&:to_i).reduce(:*) }.sum
