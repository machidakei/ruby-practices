#!/usr/bin/env ruby

class Table
  def print_table(array)
    for i in 0..(array.length-1) do
      for j in 0..(array[0].length-1) do
        print array[i][j].to_s.ljust(array.flatten.compact.max_by { |name| name.length }.length), "\t"
      end
      puts ""
    end
  end
end

array = []

Dir.glob('*') do |item|
  array << item
end

row_length = array.length.divmod(3)[0]
horizontal_array = array.sort.each_slice(row_length + 1).map { |arr| arr } 

number_of_blank = row_length - array.size.divmod(3)[1]
number_of_blank.times do
  horizontal_array[-1] << nil
end

vertical_array = horizontal_array.transpose

t = Table.new
t.print_table(vertical_array)
