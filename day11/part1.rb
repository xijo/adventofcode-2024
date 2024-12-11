#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/11

require 'byebug'

# stones = File.read('day11/example').strip.split.tally
stones = File.read('day11/input').strip.split.map(&:to_i).tally
start = Time.now

(1..75).each do |iteration|
  new_stones = Hash.new(0)

  stones.each do |i, n|
    case
    when i.zero?
      new_stones[1] += n
    when i.digits.length.odd?
      new_stones[(i.to_i * 2024)] += n
    else
      front, back = i.to_s.scan(/\d{#{i.digits.length / 2}}/).map(&:to_i)
      new_stones[front] += n
      new_stones[back] += n
    end
  end
  stones = new_stones

  puts "#{iteration}: #{stones.values.sum.to_s.rjust(40)} stones (#{((Time.now - start) * 1000).round}ms)" if iteration % 25 == 0
end
