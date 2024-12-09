#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/5

input = File.read('day05/input')
# input = File.read('day05/example')

def valid_sequence?(seq, rules)
  rules.all? do |before, after|
    next true unless seq.include?(before) && seq.include?(after)
    seq.index(before) < seq.index(after)
  end
end

rules, sequences = input.split("\n\n")
rules = rules.lines.map { |line| line.strip.split('|').map(&:to_i) }

result = sequences
  .lines.map { |line| line.strip.split(',').map(&:to_i) }
  .filter_map { |seq| seq[seq.length / 2] if valid_sequence?(seq, rules) }
  .sum

puts result
