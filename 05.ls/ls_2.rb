#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts("a")

def print_table(elements_of_table)
  length = elements_of_table.flatten.compact.max_by(&:length).length
  elements_of_table.each do |row|
    row.each do |item|
      print item.to_s.ljust(length), "\t"
    end
    puts ''
  end
end

if options == true
  array = Dir.glob('*', File::FNM_DOTMATCH)
else
  array = Dir.glob('*')
end

row_length = array.length / 3
row_length += 1 if array.length % 3 != 0
horizontal_array = array.sort.each_slice(row_length).to_a

number_of_blank = row_length * 3 - array.length
number_of_blank.times do
  horizontal_array[-1] << nil
end

vertical_array = horizontal_array.transpose

print_table(vertical_array)
