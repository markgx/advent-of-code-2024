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

counts = {}

right_list.each do |num|
  counts[num] = counts.fetch(num, 0) + 1
end

similarity_score = 0

left_list.each do |num|
  similarity_score += num * counts.fetch(num, 0)
end

puts "The similarity score is #{similarity_score}"
