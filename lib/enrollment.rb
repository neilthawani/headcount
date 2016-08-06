class Enrollment
  attr_accessor :name, :high_school_graduation_rates
  attr_reader :kindergarten_participation

  def initialize(enrollment_data)
    @name = enrollment_data[:name]
    @kindergarten_participation = enrollment_data[:kindergarten_participation]
    @high_school_graduation_rates = enrollment_data[:high_school_graduation_rates]
  end
end
