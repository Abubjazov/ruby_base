# frozen_string_literal: true

# code = '1 + 2'
# puts RubyVM::InstructionSequence.compile(code).disasm

# require 'benchmark'

# # Способ 1: Чистый yield
# def fast_method
#   yield
# end

# # Способ 2: Овеществление блока через &
# def slow_method(&block)
#   block.call
# end

# Benchmark.bm(12) do |x|
#   x.report('Использование yield:') { 10_000_000.times { fast_method { 1 + 1 } } }
#   x.report('Через &block.call:') { 10_000_000.times { slow_method { 1 + 1 } } }
# end

# Валидатор
class AgeRestriction
  def initialize(min, max)
    @min = min
    @max = max
  end

  # Реализуем to_proc
  def to_proc
    # Возвращаем лямбду или Proc, который принимает один элемент
    ->(age) { age.between?(@min, @max) }
  end
end

# Создаем конкретные правила
adult_only = AgeRestriction.new(18, 65)
kids_only  = AgeRestriction.new(0, 12)

all_ages = [10, 15, 20, 35, 70, 8]

# Передаем наш объект через амперсанд!
# Ruby сам вызовет adult_only.to_proc и применит его к массиву
p all_ages.select(&adult_only) #=> [20, 35]
p all_ages.select(&kids_only)  #=> [10, 8]

# Извлекатор
class NestedFetcher
  def initialize(*keys)
    @keys = keys
  end

  def to_proc
    # Возвращаем Proc, который последовательно копает хэш по ключам
    proc { |hash| hash.dig(*@keys) }
  end
end

# Создаем экстрактор для получения города из профиля пользователя
get_city = NestedFetcher.new(:profile, :address, :city)

users = [
  { name: 'Иван', profile: { address: { city: 'Москва' } } },
  { name: 'Олег', profile: { address: { city: 'Казань' } } }
]

# Изящно трансформируем массив
p users.map(&get_city) #=> ["Москва", "Казань"]

# Вот так это будет работать идеально:
result = [1, 2, 3].map { |x| x * 2 }.tap { |array| p array }.sum
result = [1, 2, 3].map { |x| x * 2 }.then { |array| p array }.sum

# В консоли напечатается промежуточный массив: [2, 4, 6]
# А в переменную result запишется итоговая сумма: 12
