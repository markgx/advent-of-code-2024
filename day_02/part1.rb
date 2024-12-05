GRADUAL_MIN_THRESHOLD = 1
GRADUAL_MAX_THRESHOLD = 3

def sequence_satisfied?(numbers)
  numbers.each_with_index do |curr_num, i|
    next_num = numbers[i + 1]
    break if next_num.nil?

    unless yield(curr_num, next_num)
      return false
    end
  end

  true
end

File.open('input.txt', 'r') do |input_file|
  safe_count = 0

  input_file.each_line do |line|
    numbers = line.split(' ').map(&:to_i)

    is_gradually_changing_check = Proc.new do |curr_num, next_num|
      difference = (curr_num - next_num).abs

      difference >= GRADUAL_MIN_THRESHOLD && difference <= GRADUAL_MAX_THRESHOLD
    end

    if (
        sequence_satisfied?(numbers) {|curr_num, next_num| curr_num < next_num } ||
        sequence_satisfied?(numbers) {|curr_num, next_num| curr_num > next_num }
      ) && sequence_satisfied?(numbers, &is_gradually_changing_check)
      safe_count += 1
    end
  end

  puts "Number of reports safe: #{safe_count}"
end
