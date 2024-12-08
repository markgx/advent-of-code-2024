# frozen_string_literal: true

SEARCH_TERM = 'XMAS'

def count_in_list(list)
  count = 0
  i = 0

  while i <= list.length - SEARCH_TERM.length
    current_word = list[i...(i + SEARCH_TERM.length)].join('')

    count += 1 if current_word == SEARCH_TERM

    i += 1
  end

  count
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

rows.each do |row|
  # scan left to right
  found_count += count_in_list(row)

  # scan right to left
  found_count += count_in_list(row.reverse)
end

(0...col_count).each do |col|
  # scan top to bottom
  column = rows.map { |row| row[col] }

  found_count += count_in_list(column)

  # scan bottom to top
  found_count += count_in_list(column.reverse)
end

# scan top left to bottom right and reverse - top half
(0...col_count).each do |col|
  curr_row = 0
  curr_col = col

  new_list = []

  while curr_row < row_count && curr_col < col_count
    new_list << rows[curr_row][curr_col]
    curr_row += 1
    curr_col += 1
  end

  found_count += count_in_list(new_list)
  found_count += count_in_list(new_list.reverse)
end

# scan top left to bottom right and reverse - bottom half
(1...row_count).each do |row|
  curr_row = row
  curr_col = 0

  new_list = []

  while curr_row < row_count && curr_col < col_count
    new_list << rows[curr_row][curr_col]
    curr_row += 1
    curr_col += 1
  end

  found_count += count_in_list(new_list)
  found_count += count_in_list(new_list.reverse)
end

# scan top right to bottom left and reverse - top half
(0...col_count).each do |col|
  curr_row = 0
  curr_col = col

  new_list = []

  while curr_row < row_count && curr_col >= 0
    new_list << rows[curr_row][curr_col]
    curr_row += 1
    curr_col -= 1
  end

  found_count += count_in_list(new_list)
  found_count += count_in_list(new_list.reverse)
end

# scan top right to bottom left and reverse - bottom half
(1...row_count).each do |row|
  curr_row = row
  curr_col = col_count - 1

  new_list = []

  while curr_row < row_count && curr_col >= 0
    new_list << rows[curr_row][curr_col]
    curr_row += 1
    curr_col -= 1
  end

  found_count += count_in_list(new_list)
  found_count += count_in_list(new_list.reverse)
end

puts "Found #{SEARCH_TERM} #{found_count} times"
