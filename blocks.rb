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

# Метод принимает блок и превращает его в Proc-объект `my_block`
def execute_and_log(&my_block)
  puts 'Старт метода'

  # Теперь my_block — это обычный Proc, вызываем через .call
  my_block.call if block_given?

  puts 'Конец метода'
end

# Передаем обычный блок (в фигурных скобках)
execute_and_log { puts 'Привет из блока!' }

# Метод ожидает блок через yield (без явного & в аргументах)
def print_twice
  yield
  yield
end

# У нас есть готовый Proc
say_hi = proc { puts 'Привет!' }

# Передаем Proc, «распаковывая» его амперсандом в блок
print_twice(&say_hi)
