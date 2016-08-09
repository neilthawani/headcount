class Enrollment
  attr_accessor :name, :high_school_graduation_rates
  attr_reader :kindergarten_participation

  def initialize(data)
    @name = data[:name]
    @kindergarten_participation = data[:kindergarten_participation]
    @high_school_graduation_rates = data[:high_school_graduation_rates]
  end
end
