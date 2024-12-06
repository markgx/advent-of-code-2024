# frozen_string_literal: true

GRADUAL_MIN_THRESHOLD = 1
GRADUAL_MAX_THRESHOLD = 3

def sequence_satisfied?(numbers)
  numbers.each_with_index do |curr_num, i|
    next_num = numbers[i + 1]
    break if next_num.nil?

    return false unless yield(curr_num, next_num)
  end

  true
end

def safe_row?(numbers)
  is_gradually_changing_check = proc do |curr_num, next_num|
    difference = (curr_num - next_num).abs

    difference >= GRADUAL_MIN_THRESHOLD && difference <= GRADUAL_MAX_THRESHOLD
  end

  (sequence_satisfied?(numbers) { |curr_num, next_num| curr_num < next_num } ||
  sequence_satisfied?(numbers) { |curr_num, next_num| curr_num > next_num }) &&
    sequence_satisfied?(numbers, &is_gradually_changing_check)
end

def can_be_saved?(numbers)
  numbers.each_with_index do |_, index_to_remove|
    numbers_minus_index = numbers.reject.with_index { |_, index| index == index_to_remove }

    return true if safe_row?(numbers_minus_index)
  end

  false
end

File.open('input.txt', 'r') do |input_file|
  safe_count = 0

  input_file.each_line do |line|
    numbers = line.split(' ').map(&:to_i)

    next unless safe_row?(numbers) || can_be_saved?(numbers)

    safe_count += 1
  end

  puts "Number of reports safe: #{safe_count}"
end
