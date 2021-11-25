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

(first_date.day..last_date.day).each do |date|
  print date.to_s + "  " if date <= 9
  print date.to_s + " " if date >= 10
  day_of_first_date += 1
  if day_of_first_date % 7 == 0
    print "\n" 
  end
end
print "\n"
