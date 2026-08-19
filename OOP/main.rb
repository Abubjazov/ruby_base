require_relative 'animals'

Pulbka = Dog.new "Pulbka", 3

puts Pulbka.inspect
puts Pulbka.name
puts Pulbka.age

Pulbka.age = 10

puts Pulbka.inspect
puts Pulbka.age
Pulbka.speak

# monkey-patching