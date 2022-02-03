#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

@options = ARGV.getopts('l')

def print_table(elements_of_table)
  length = elements_of_table.flatten.compact.max_by(&:length).length
  elements_of_table.each do |row|
    row.each do |item|
      print item.to_s.ljust(length), "\t"
    end
    puts ''
  end
end

def newfile(file)
  File::Stat.new(file)
end

def listup_in_detail(files)
  files_in_array = [files]
  files_in_array.unshift(get_filemode_and_file_access_authorization(files),
   get_number_of_hardlink(files), get_user_name(files), get_group_name(files),
   get_bytesize(files), get_date_and_time(files))
end

def get_filemodes(files)
  filetypes = files.map { |file| newfile(file).ftype }
  filetype_list = { 'fifo' => 'p', 'characterSpecial' => 'c', 'directory' => 'd', 'blockSpecial' => 'b', 'file' => '-', 'link' => 'l', 'socket' => 's' }
  filetypes.map { |filetype| filetype_list[filetype] }
end

def get_file_access_authorization(files)
  permitted_attributes = files.map { |file| File::Stat.new(file).mode.to_s(8).to_i.digits.take(3).reverse }
  file_access_authorization_list = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }
  permitted_attributes.map do |permitted_attribute|
    [file_access_authorization_list[permitted_attribute[0]],
      file_access_authorization_list[permitted_attribute[1]],
      file_access_authorization_list[permitted_attribute[2]]].join
  end
end

def get_filemode_and_file_access_authorization(files)
  get_filemodes(files).map.with_index do |filemode, i|
    filemode + get_file_access_authorization(files)[i]
  end
end

def get_number_of_hardlink(files)
  files.map { |file| newfile(file).nlink.to_s }
end

def get_user_name(files)
  files.map { |file| Etc.getpwuid(newfile(file).uid).name }
end

def get_group_name(files)
  files.map { |file| Etc.getgrgid(newfile(file).gid).name }
end

def get_date_and_time(files)
  files.map { |file| File.open(file, 'r').mtime.strftime('%_m %e %H:%M') }
end

def get_bytesize(files)
  files.map { |file| file.bytesize.to_s }
end

def print_table_with_l_option(elements_of_table)
  elements_of_table.each do |row|
    row.each do |item|
      print "#{item.to_s.ljust(2)} "
    end
    puts ''
  end
end

def create_vertical_array(files)
  row_length = files.length / 3
  row_length += 1 if files.length % 3 != 0
  horizontal_array = files.each_slice(row_length).to_a

  number_of_blank = row_length * 3 - files.length
  number_of_blank.times do
    horizontal_array[-1] << nil
  end
  horizontal_array.transpose
end

files = Dir.glob('*').sort

if @options['l']
  files_in_array = listup_in_detail(files)
  print_table_with_l_option(files_in_array.transpose)
else
  vertical_array = create_vertical_array(files)
  print_table(vertical_array)
end
