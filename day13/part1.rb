#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/13
input = File.read('day13/input').strip
# input = File.read('day13/example').strip

machines = input.split("\n\n").map do |machine|
  machine.scan(/\d+/).map(&:to_i)
end

# use cramers theorem to solve the system of equations
solutions = machines.map do |ax, ay, bx, by, px, py|
  press_a = (px * by - py * bx).to_f / (ax * by - ay * bx)
  press_b = (ax * py - ay * px).to_f / (ax * by - ay * bx)

  if press_a == press_a.round && press_b == press_b.round
    (press_a * 3 + press_b).round
  end
end.compact

puts solutions.sum
