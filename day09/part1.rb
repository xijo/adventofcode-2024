#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/9

input = File.read('day09/input').strip
# input = File.read('day09/example').strip

def parse_disk(input)
  result = []
  file_id = 0
  input.each_char.each_slice(2) do |file_size, space_size|
    file_size.to_i.times { result << file_id }
    space_size.to_i.times { result << '.' } if space_size
    file_id += 1
  end
  result
end

def compact?(disk)
  disk.index(?.) > disk.rindex { _1 != ?. }
end

def move_block(disk)
  right_idx = disk.rindex { |x| x != '.' }
  puts "moving block from #{right_idx}"
  left_idx = disk.index('.')

  disk[left_idx], disk[right_idx] = disk[right_idx], '.'
  disk
end

def calculate_checksum(disk)
  disk.each_with_index.sum do |block, pos|
    block == '.' ? 0 : pos * block
  end
end

disk = parse_disk(input)
until compact?(disk)
  disk = move_block(disk)
  # puts disk.join
end

# again runtime is shit but i'm too lazy to optimize ¯\_(ツ)_/¯
# lets see if i can get around it or need to do it for part 2
puts calculate_checksum(disk)
