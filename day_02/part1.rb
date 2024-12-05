def all_increasing?(numbers)
  numbers.each_with_index do |current, i|
    next_number = numbers[i + 1]
    break if next_number.nil?

    if current >= next_number
      return false
    end
  end

  true
end

def all_decreasing?(numbers)
  numbers.each_with_index do |current, i|
    next_number = numbers[i + 1]
    break if next_number.nil?

    if current <= next_number
      return false
    end
  end

  true
end

def all_gradually_changing?(numbers)
  numbers.each_with_index do |current, i|
    next_number = numbers[i + 1]
    break if next_number.nil?

    difference = (current - next_number).abs

    if difference < 1 || difference > 3
      return false
    end
  end

  true
end

File.open('input.txt', 'r') do |input_file|
  safe_count = 0

  input_file.each_line do |line|
    numbers = line.split(' ').map(&:to_i)

    if (all_increasing?(numbers) || all_decreasing?(numbers)) && all_gradually_changing?(numbers)
      safe_count += 1
    end
  end

  puts "Number of reports safe: #{safe_count}"
end
