#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/9

require 'tty-progressbar'

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

def find_file_size(disk, file_id)
  disk.count(file_id)
end

def find_first_fit(disk, size)
  # Find first span of free spaces that can fit the file
  count = 0
  disk.each_with_index do |block, i|
    if block == '.'
      count += 1
      return i - count + 1 if count == size
    else
      count = 0
    end
  end
  nil
end

disk = parse_disk(input)
max_id = disk.reject { _1 == ?. }.max
bar = TTY::ProgressBar.new("defrag [:bar] :eta", total: max_id)

max_id.downto(0) do |file_id|
  next unless disk.include?(file_id)  # Skip if file doesn't exist

  file_size = find_file_size(disk, file_id)
  # puts disk.join
  # puts "Moving file #{file_id} with size #{file_size}"
  bar.advance
  if pos = find_first_fit(disk, file_size)
    # Move whole file to position
    old_pos = disk.index(file_id)
    next if old_pos <= pos
    file_size.times do |i|
      disk[pos + i] = file_id
      disk[old_pos + i] = '.'
    end
  end
end

puts disk.each_with_index.sum { |block, pos| block == '.' ? 0 : pos * block }
