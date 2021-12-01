#!/usr/bin/env ruby

require 'date'
require 'optparse'

options = ARGV.getopts("", "m:#{Date.today.month}", "y:#{Date.today.year}")

year = options['y'].to_i
month = options['m'].to_i

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)

puts first_date.strftime("%m月 %Y").center(20)

puts "日 月 火 水 木 金 土 "

day_of_first_date = first_date.wday

print "   " * day_of_first_date

(first_date..last_date).each do |date|
  print date.day.to_s.ljust(3)
  if date.saturday?
    print "\n" 
  end
end
print "\n"
