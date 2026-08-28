# frozen_string_literal: true

# p = proc { |arg| puts "Hello from Proc #{arg.inspect}" }

# p.call

# l = ->(arg) { puts "Hello from Lambda #{arg.inspect}" }

# l.call(1)

def demo(obj)
  puts 'before obj call'
  obj.call
  puts 'after obj call'
end

p1 = proc do
  puts 'Proc 1'

  return 42
end

l1 = lambda do
  puts 'Lambda 1'

  42
end

# resp = demo(p1)
# resl = demo(l1)

# res = p1.call

# puts resp.inspect
# puts resl.inspect

def f1
  puts 'Func 1'
  self
end

puts p1.inspect
puts l1.inspect
puts f1.inspect
