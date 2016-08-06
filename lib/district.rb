require 'pry'

class District
  attr_reader :name
  attr_accessor :enrollment_data

  def initialize(name)
    @name = name[:name]
  end

  def calculate_field_average(enrollment_key)
    values = enrollment_data.send(enrollment_key).values
    values_sum = values.reduce(:+)

    average_value_distribution = values_sum / values.count
    average_value_distribution.round(3)
  end
end
