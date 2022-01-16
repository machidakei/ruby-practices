#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts("r")

def print_table(elements_of_table)
  length = elements_of_table.flatten.compact.max_by(&:length).length
  elements_of_table.each do |row|
    row.each do |item|
      print item.to_s.ljust(length), "\t"
    end
    puts ''
  end
end

array = Dir.glob('*')

row_length = array.length / 3
row_length += 1 if array.length % 3 != 0
if options["r"]
  horizontal_array = array.sort.reverse.each_slice(row_length).to_a
else
  horizontal_array = array.sort.each_slice(row_length).to_a
end

number_of_blank = row_length * 3 - array.length
number_of_blank.times do
  horizontal_array[-1] << nil
end

vertical_array = horizontal_array.transpose

print_table(vertical_array)
