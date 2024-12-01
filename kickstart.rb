#!/usr/bin/env ruby

require 'fileutils'
require 'open-uri'
require 'byebug'
require 'nokogiri'

day = ARGV[0].to_i
folder = "day#{"%02d" % day}"

blueprint =<<~EOS
#!/usr/bin/env ruby
# https://adventofcode.com/2023/day/#{day}

# input = File.read('#{folder}/input').lines.map(&:strip)
input = File.read('#{folder}/example').lines.map(&:strip)
EOS

FileUtils.mkdir_p(folder)

unless File.exist?("#{folder}/part1.rb")
  File.open("#{folder}/part1.rb", "w") { |f| f.write blueprint }
end

unless File.exist?("#{folder}/part2.rb")
  File.open("#{folder}/part2.rb", "w") { |f| f.write blueprint }
end

unless File.exist?("#{folder}/example")
  example = Nokogiri::XML(URI.open("https://adventofcode.com/2024/day/#{day}").read).css('pre').first.text
  File.open("#{folder}/example", "w") { |f| f.write example }
end

input = URI.open("https://adventofcode.com/2024/day/#{day}/input", "Cookie" => File.read('.session')).read
File.open("#{folder}/input", "w") { |f| f.write input }

`code #{folder}/part1.rb`
