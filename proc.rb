# frozen_string_literal: true

proc1 = proc { |str| puts "Hello from proc1 #{str.upcase}" }

proc1.call('my string')

def caller(my_proc)
  puts my_proc.call(10, 20)

  yield
end

my_proc1 = proc { |a, b| a + b }

caller my_proc1 do
  puts 'Block passed to caller.'
end
