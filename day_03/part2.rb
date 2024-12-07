# frozen_string_literal: true

input = File.read('input.txt').gsub("\n", '')
input = "do()#{input}don't()"

block_matches = input.scan(/(do\(\).*?don't\(\))/)

total = 0

block_matches.each do |line|
  matches = line[0].scan(/mul\((\d+),(\d+)\)/)

  matches.each do |x, y|
    total += x.to_i * y.to_i
  end
end

puts "Total of all multiplications: #{total}"
