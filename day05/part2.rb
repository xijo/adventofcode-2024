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

def correct_order(numbers, rules)
  dependencies = Hash.new(0)
  graph = Hash.new { |h,k| h[k] = [] }

  rules.each do |before, after|
    next unless numbers.include?(before) && numbers.include?(after)
    graph[before] << after
    dependencies[after] += 1
  end

  queue = numbers.select { |n| dependencies[n] == 0 } # numbers with no dependencies
  sorted_seq = []

  while n = queue.shift
    sorted_seq << n
    graph[n].each do |next_n|
      dependencies[next_n] -= 1
      queue << next_n if dependencies[next_n] == 0
    end
  end

  sorted_seq
end

rules, sequences = input.split("\n\n")
rules = rules.lines.map { |line| line.strip.split('|').map(&:to_i) }

invalid_sequences = sequences
  .lines.map { |line| line.strip.split(',').map(&:to_i) }
  .filter_map { |seq| seq unless valid_sequence?(seq, rules) }

result = invalid_sequences.map { |seq| correct_order(seq, rules)[seq.size / 2] }.sum
puts result
