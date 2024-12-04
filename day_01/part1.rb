left_list = []
right_list = []

File.open('input.txt', 'r') do |input_file|
  input_file.each_line do |line|
    numbers = line.split('   ')
    left_num, right_num = numbers.map(&:to_i)

    left_list << left_num
    right_list << right_num
  end
end

left_list.sort!
right_list.sort!

difference = 0

left_list.zip(right_list) do |left, right|
  difference += (left - right).abs
end

puts "The difference between the lists is #{difference}"
