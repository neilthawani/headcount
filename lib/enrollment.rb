require 'pry'
require_relative 'district'
class Enrollment
  attr_accessor :name, :kindergarten_participation, :school_data #:high_school_graduation_rates,

  def initialize(enrollment_data)
    @name = enrollment_data[:name]
    # @kindergarten_participation = enrollment_data[:kindergarten_participation]

    @school_data = {kindergarten_participation: enrollment_data[:kindergarten_participation], high_school_graduation_rates: enrollment_data[:high_school_graduation_rates]}
    #binding.pry
    
  #   @high_school_graduation_rates = @school_data[:high_school_graduation_rates]
  end

  def high_school_graduation_rates
    school_data[:high_school_graduation_rates]
  end


  def kindergarten_participation_in_year(year = nil)
    if year
      kindergarten_participation[year]
    else
      kindergarten_participation
    end
  end

  def graduation_rate_by_year
    high_school_graduation_rates
  end

  def graduation_rate_in_year(year)
    high_school_graduation_rates[year]
  end
end
