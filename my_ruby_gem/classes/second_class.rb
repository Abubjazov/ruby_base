# frozen_string_literal: true

require_relative 'my_lib'

# Second
class Second
  include MyLib

  def my_instance_method
    puts 'Hi from Second'

    helper2
  end
end

obj = Second.new

obj.my_instance_method
