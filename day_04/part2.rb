# frozen_string_literal: true

MAS = 'MAS'

def mas?(rows, row, col)
  # top left to bottom right
  diagonal1 = "#{rows[row - 1][col - 1]}#{rows[row][col]}#{rows[row + 1][col + 1]}"
  # top right to bottom left
  diagonal2 = "#{rows[row - 1][col + 1]}#{rows[row][col]}#{rows[row + 1][col - 1]}"

  (diagonal1 == MAS || diagonal1.reverse == MAS) &&
    (diagonal2 == MAS || diagonal2.reverse == MAS)
end

rows = []

File.open('input.txt', 'r') do |input_file|
  input_file.each_line do |line|
    rows << line.chomp.chars
  end
end

row_count = rows.count
col_count = rows.first.count
found_count = 0

(1...row_count - 1).each do |row|
  (1...col_count - 1).each do |col|
    found_count += 1 if rows[row][col] == 'A' && mas?(rows, row, col)
  end
end

puts "Found XMAS #{found_count} times"
