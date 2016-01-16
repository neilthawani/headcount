require_relative 'enrollment'
require 'bigdecimal'
class District
  attr_reader :name

  def initialize(name)
    @name = name[:name]
  end

  def enrollment
    @enrollment_data
  end

  def get_enrollment(data)
    @enrollment_data = data
  end

  def kindergarten_participation

    values = enrollment.kindergarten_participation.values
    values.map { |v| BigDecimal.new(v) }.reduce(:+)

    #this returns kindergarten_participation all the years added together
    #we still need to divide this to get the average
    #next we need to get the state average and divide by district average. cool!!
  end
end

District.new(name: "ACADEMY 20")




nil && 1 # => nil
2 && 1 # => 1
1 && 2 # => 2
