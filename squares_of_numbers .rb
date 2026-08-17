array = []

10.times do |i|
    array << i + 1
end

array.each do |elem|
    puts "#{elem} --> #{elem ** 2}"
end

puts "\n-------------------------\n"

#####################################

array = (1..10).to_a

array.each do |elem|
    puts "#{elem} --> #{elem ** 2}"
end

puts "\n-------------------------\n"

#####################################

(1..10).each do |elem|
    puts "#{elem} --> #{elem ** 2}"
end

puts "\n-------------------------\n"