#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2).with_index do |s, i|
  frames << s if i <= 8
end
frame_of_tenth_shot_including_nil = [shots[18], shots[19], shots[20], shots[21], shots[22], shots[23]]
frame_of_tenth_shot = frame_of_tenth_shot_including_nil.map(&:to_i)
frames << frame_of_tenth_shot

point = 0
frames.each_with_index do |frame, i|
  point += if i <= 7
             if frame[0] == 10
               if frames[i + 1][0] == 10
                 10 + 10 + frames[i + 2][0]
               else
                 10 + frames[i + 1].sum
               end
             elsif frame.sum == 10
               frames[i].sum + frames[i + 1][0]
             else
               frame.sum
             end
           end
end
point += if frames[8][0] == 10
           if frames[9][0] == 10
             10 + 10 + frames[9][2]
           else
             10 + frames[9][0] + frames[9][1]
           end
         elsif frames[8].sum == 10
           10 + frames[9][0]
         else
           frames[8].sum
         end
point += frames[9].sum

puts point
