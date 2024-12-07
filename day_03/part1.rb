# frozen_string_literal: true

File.open('input.txt', 'r') do |input_file|
  total = 0

  input_file.each_line do |line|
    matches = line.scan(/mul\((\d+),(\d+)\)/)

    matches.each do |x, y|
      total += x.to_i * y.to_i
    end
  end

  puts "Total of all multiplications: #{total}"
end
