# frozen_string_literal: true

def build_rule(after_rules, line)
  before, after = line.split('|').map(&:to_i)
  after_rules[before] = after_rules[before].nil? ? [after] : after_rules[before] << after
end

def process_pages(after_rules, line)
  numbers = line.split(',').map(&:to_i)

  (0...numbers.count - 1).each do |i|
    current = numbers[i]

    ((i + 1)..numbers.count).each do |j|
      next_num = numbers[j]

      return 0 if after_rules[next_num]&.include?(current)
    end
  end

  numbers[numbers.count / 2]
end

after_rules = {} # numbers that come after the key

middle_number_total = 0

File.open('input.txt', 'r') do |input_file|
  mode = :reading_rules

  input_file.each_line do |line|
    if line == "\n"
      mode = :reading_updates
      next
    end

    if mode == :reading_rules
      build_rule(after_rules, line)
    elsif mode == :reading_updates
      middle_number_total += process_pages(after_rules, line)
    end
  end
end

puts "Middle page number total #{middle_number_total}"
