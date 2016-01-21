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

   def calculate_kinder_average
     enrollment_percentages = enrollment.kindergarten_participation.values

     total_enrollment = enrollment_percentages.map { |percent| percent.to_f  }.reduce(:+)

     average_district_percentage = total_enrollment/enrollment_percentages.count
     average_district_percentage.round(3)
   end

end

District.new(name: "ACADEMY 20")


#this returns kindergarten_participation all the years added together
#we still need to divide this to get the average
#next we need to get the state average and divide by district average. cool!!

nil && 1 # => nil
2 && 1 # => 1
1 && 2 # => 2
