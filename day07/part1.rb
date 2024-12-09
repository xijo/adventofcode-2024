#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/7

input = File.read('day07/input').lines.map(&:strip)
# input = File.read('day07/example').lines.map(&:strip)

result = input.filter_map do |line|
  result, *values = line.scan(/\d+/)
  result = result.to_i  # convert only the test value to integer
  values = values.map(&:to_i)

  calcs = [?+, ?*].repeated_permutation(values.size - 1).map { values.zip(_1).flatten.compact }
  matches = calcs.any? do |calc|
    sum = calc.shift
    calc.each_slice(2) do |op, n|
      sum = op == ?+ ? sum + n : sum * n
      break if sum > result
    end
    sum == result
  end

  matches ? result : nil
end.sum

puts result
