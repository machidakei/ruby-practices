# 1から20までの数をプリントするプログラムを書け。
(1..20).each do |x|
  # 3と5両方の倍数の場合には｢FizzBuzz｣とプリントすること。
  if x % 3 == 0 && x % 5 == 0
    puts "FizzBuzz"
  # ただし3の倍数のときは数の代わりに｢Fizz｣と、
  elsif x % 3 == 0
    puts "Fizz"
  # 5の倍数のときは｢Buzz｣とプリントし、
  elsif x % 5 == 0
    puts "Buzz"
  else
    puts x
  end
end
