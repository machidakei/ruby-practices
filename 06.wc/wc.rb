#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

@options = ARGV.getopts('l')

def count_lines(text)
  lines = text.count("\n")
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

ARGV.each do |argument|
  text = File.read(argument)
  total_lines += count_lines(text)
  total_words += count_words(text)
  total_bytesize += count_bytesize(text)
  puts "\t#{count_lines(text)}\t#{count_words(text)}\t#{count_bytesize(text)} #{ARGV[0]}"
end
puts "\t#{total_lines}\t#{total_words}\t#{total_bytesize} total" if ARGV.size > 1
