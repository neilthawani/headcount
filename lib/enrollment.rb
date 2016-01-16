require 'pry'
class Enrollment
  attr_reader :name, :kindergarten_participation

  def initialize(enrollment_data)
    @name = enrollment_data[:name]
    @kindergarten_participation = enrollment_data[:kindergarten_participation]
  end

  def kindergarten_participation_in_year(year = nil)
    if year
      kindergarten_participation[year.to_s].to_f
    else
      kindergarten_participation
    end
  end
end
