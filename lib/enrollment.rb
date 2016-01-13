class Enrollment

  def initialize(enrollment_data)
    @enrollment_data =
  end

  e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677})




#   def kindergarten_participation_by_year
#   end
#     enrollment.kindergarten_participation_by_year
#   => { 2010 => 0.391,
#        2011 => 0.353,
#        2012 => 0.267,
#      }
#   def kindergarten_participation_in_year(year)
#   end
#
# end

#enrollment.kindergarten_participation_in_year(2010) # => .391
