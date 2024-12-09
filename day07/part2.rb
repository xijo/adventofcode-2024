#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/7

# input = File.read('day07/input').lines.map(&:strip)
input = File.read('day07/example').lines.map(&:strip)

# hahaha alright, it takes a couple of minutes so whatever. I put some progress
# in and let the CPU burn muhahahaarrr
result = input.filter_map.with_index do |line, i|
  result, *values = line.scan(/\d+/).map(&:to_i)
  puts "processing line #{i}: #{result}"
  calcs = [?+, ?*, '||'].repeated_permutation(values.size - 1).map { values.zip(_1).flatten.compact }
  calcs.any? do |calc|
    sum = calc.shift
    calc.each_slice(2) do |op, n|
      sum = case op
            when ?+ then sum + n
            when ?* then sum * n
            when '||' then "#{sum}#{n}".to_i
            end
      break if sum > result
    end
    sum == result
  end ? result : nil
end.sum

puts result
