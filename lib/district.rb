require_relative 'enrollment'
class District
  attr_reader :name

  def initialize(name)
    @name = name[:name]
  end

  def enrollment
    #return an Enrollment object???
    @enrollment_data
  end

  def get_enrollment(data)
    @enrollment_data = data
  end
end

District.new(name: "ACADEMY 20")




nil && 1 # => nil
2 && 1 # => 1
1 && 2 # => 2
