# frozen_string_literal: true

require_relative 'my_lib'

# First Parent
class FirstParent
  extend MyLib
  include MyLib
end

# First
class First
  include MyLib

  def my_instance_method
    puts 'Hi from First'

    helper1
  end
end

obj = First.new

obj.my_instance_method

FirstParent.helper2

obj2 = FirstParent.new

obj2.helper1
