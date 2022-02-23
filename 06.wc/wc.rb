#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

option = ARGV.getopts('l')

def count_lines(text)
  text.count("\n")
end

def count_words(text)
  text_in_array = text.split(/\s+/)
  text_in_array.size
end

def count_bytesize(text)
  text.bytesize
end

total_lines = 0
total_words = 0
total_bytesize = 0

ARGV.each do |filename|
  text = File.read(filename)
  total_lines += count_lines(text)
  total_words += count_words(text)
  total_bytesize += count_bytesize(text)
  if option['l']
    puts count_lines(text).to_s.rjust(8) + " #{filename}"
  else
    puts count_lines(text).to_s.rjust(8) + count_words(text).to_s.rjust(8) + count_bytesize(text).to_s.rjust(8) + " #{filename}"
  end
end

if ARGV.size > 1
  if option['l']
    puts "#{total_lines.to_s.rjust(8)} total"
  else
    puts "#{total_lines.to_s.rjust(8)}#{total_words.to_s.rjust(8)}#{total_bytesize.to_s.rjust(8)} total"
  end
end

if ARGV == []
  inputs = readlines
  inputs.each do |input|
    text = input
    total_lines += count_lines(text)
    total_words += count_words(text)
    total_bytesize += count_bytesize(text)
    if option['l']
      puts total_lines.to_s.rjust(8)
    else
      puts total_lines.to_s.rjust(8) + total_words.to_s.rjust(8) + total_bytesize.to_s.rjust(8)
    end
  end
end
