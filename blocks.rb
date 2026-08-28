# frozen_string_literal: true

[1, 2, 3].each do |item|
  puts item
end

new_arr = [1, 2, 3].map do |item|
  item + 3
end

puts new_arr

def demo(arg1, arg2)
  puts "#{arg1}#{arg2}"

  return unless block_given?

  yield(arg1, arg2)
end

demo(13, 31) do |arg1, arg2|
  puts "#{arg2}#{arg1}"
end

def demo2(*args, &block)
  return unless block_given?

  args.each(&block)
end

demo2(13, 31, 5, 7, 6, 3, 2, &:odd?)

def method1(&block)
  # yield
  # block.call
  puts block.inspect
  method2(&block)
end

def method2(&block)
  block.call
end

method1 do
  puts 'Hello from method1'
end
