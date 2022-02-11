#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

@option = ARGV.getopts('l')

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

ARGV.each_with_index do |argument, i|
  text = File.read(argument)
  total_lines += count_lines(text)
  total_words += count_words(text)
  total_bytesize += count_bytesize(text)
  if @option['l']
    puts "\t#{count_lines(text)} #{ARGV[i]}"
  else
    puts "\t#{count_lines(text)}\t#{count_words(text)}\t#{count_bytesize(text)} #{ARGV[i]}"
  end
end

if @option['l']
  puts "\t#{total_lines} total" if ARGV.size > 1
elsif ARGV.size > 1
  puts "\t#{total_lines}\t#{total_words}\t#{total_bytesize} total"
end
