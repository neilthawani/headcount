
require_relative 'district_repository'
require_relative 'enrollment'
require_relative 'enrollment_repository'
require 'pry'

class HeadcountAnalyst
  attr_reader :dr, :enrollment
  def initialize(dr)
    @dr = dr
    @enrollment = EnrollmentRepository.new
  end

  def kindergarten_participation_rate_variation(district_1, district_2)
    district1 = dr.find_by_name(district_1).calculate_kinder_average
    district2 = dr.find_by_name(district_2[:against]).calculate_kinder_average
    (district1/district2).round(3)
  end

  def kindergarten_participation_rate_variation_trend(district_1, district_2)
    district_trend = Hash.new
    district1 = dr.find_by_name(district_1).enrollment.kindergarten_participation
    district2 = dr.find_by_name(district_2[:against]).enrollment.kindergarten_participation
    district1.each do |year, participation|
      district_trend[year.to_i] = (district1[year].to_f/ district2[year].to_f).round(3)
    end
    district_trend
  end

  def kindergarten_against_high_school_graduation(district)
    high_school_enrollment = enrollment.find_by_name(district)
    puts high_school_enrollment


    # kindergarten_variation = kindergarten_participation_rate_variation(district, :against => 'COLORADO')
     #dividing kinder participation by statwide
    #  graduation_variation = kindergarten_participation_rate_variation(district, :against => 'COLORADO')
    #  divide the districts grad rate by state avg.

  end
end
