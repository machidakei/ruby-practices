#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

@options = ARGV.getopts('l')

def print_table(elements_of_table)
  length = elements_of_table.flatten.compact.max_by(&:length).length unless @options['l']
  elements_of_table.each do |row|
    row.each do |item|
      if @options['l']
        print "#{item.to_s.ljust(2)} "
      else
        print item.to_s.ljust(length), "\t"
      end
    end
    puts ''
  end
end

def newfile(file)
  File::Stat.new(file)
end

array = Dir.glob('*').sort

if @options['l']
  filetypes = array.map { |file| newfile(file).ftype }
  filetype_list = { 'fifo' => 'p', 'characterSpecial' => 'c', 'directory' => 'd', 'blockSpecial' => 'b', 'file' => '-', 'link' => 'l', 'socket' => 's' }
  filemodes = filetypes.map { |filetype| filetype_list[filetype] }
  permitted_attributes = array.map { |file| File::Stat.new(file).mode.to_s(8).to_i.digits.take(3).reverse }
  file_access_authorization_list = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }
  file_access_authorization = permitted_attributes.map do |permitted_attribute|
    file_access_authorization_list[permitted_attribute[0]] +
      file_access_authorization_list[permitted_attribute[1]] +
      file_access_authorization_list[permitted_attribute[2]]
  end
  filemode_and_file_access_authorization = filemodes.map.with_index do |filemode, i|
    filemode + file_access_authorization[i]
  end
  number_of_hard_link = array.map { |file| newfile(file).nlink.to_s }
  user_name = array.map { |file| Etc.getpwuid(newfile(file).uid).name }
  group_name = array.map { |file| Etc.getgrgid(newfile(file).gid).name }
  date_and_time = array.map { |file| File.open(file, 'r').mtime.strftime('%_m %e %H:%M') }
  bytesize = array.map { |file| file.bytesize.to_s }
  array2 = []
  array2 << array
  array2.unshift(filemode_and_file_access_authorization, number_of_hard_link, user_name, group_name, bytesize, date_and_time)
  print_table(array2.transpose)
else
  row_length = array.length / 3
  row_length += 1 if array.length % 3 != 0
  horizontal_array = array.each_slice(row_length).to_a

  number_of_blank = row_length * 3 - array.length
  number_of_blank.times do
    horizontal_array[-1] << nil
  end
  vertical_array = horizontal_array.transpose
  print_table(vertical_array)
end
