#!/usr/bin/env ruby
# frozen_string_literal: true

class Table
  def print_table(elements_of_table)
    length = elements_of_table.flatten.compact.max_by(&:length).length
    elements_of_table.each do |row|
      row.each do |item|
        print item.to_s.ljust(length), "\t"
      end
      puts ''
    end
  end
end

array = Dir.glob('*')

row_length = array.length / 3
if array >= 4
  horizontal_array = array.sort.each_slice(row_length + 1).map { |arr| arr }
else
  horizontal_array = array.sort.each_slice(1).map { |arr| arr }

number_of_blank = row_length - array.length % 3
number_of_blank.times do
  horizontal_array[-1] << nil
end

vertical_array = horizontal_array.transpose

t = Table.new
t.print_table(vertical_array)
