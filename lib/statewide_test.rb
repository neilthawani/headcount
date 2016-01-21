require 'pry'
require_relative 'district'
class StatewideTest
  attr_accessor :name, :statewide_data

  def initialize(statewide_data)
    @name = statewide_data[:name]

    @statewide_data = {statewide_testing: statewide_data[:third_grade], statewide_testing: statewide_data[:third_grade], statewide_testing: statewide_data[:eighth_grade], statewide_testing: statewide_data[:math], statewide_testing: statewide_data[:reading], statewide_data[:writing]}
  end
  "statewide_testing" => "third_grade", "statewide_testing" => "eighth_grade", "statewide_testing" => "math", "statewide_testing" => "reading", "statewide_testing" => "writing"
  def third_grade
    statewide_data[:third_grade]
  end

  def eighth_grade
    statewide_data[:eighth_grade]
  end

  def math
    statewide_data[:math]
  end

  def reading
    statewide_data[:reading]
  end

  def writing
    statewide_data[:reading]
  end

  # def kindergarten_participation_in_year(year = nil)
  #   if year
  #     school_data[:kindergarten_participation][year]
  #   else
  #     school_data[:kindergarten_participation]
  #   end
  # end
  #
  # def graduation_rate_by_year
  #   high_school_graduation_rates
  # end
  #
  # def graduation_rate_in_year(year)
  #   high_school_graduation_rates[year]
  # end
end
