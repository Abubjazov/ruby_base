class Animal
  attr_accessor :age
  attr_reader :name

  def initialize name, age
    @name = name 
    @age = age    
  end

  def speak
    puts "SOME KIND OF SOUND"
  end 

  # def get_name
  #   return @name
  # end

  # def get_age
  #   @age
  # end

  # def age= age
  #   @age = age
  # end
end

class Dog < Animal
  def speak
    puts "WOOF!"
  end  
end

class Cat < Animal
  def speak
    puts "MEOW!"
  end  
end