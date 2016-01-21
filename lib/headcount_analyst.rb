
require_relative 'district_repository'
require_relative 'enrollment'
require_relative 'enrollment_repository'
require 'pry'

class HeadcountAnalyst
  attr_reader :dr

  def initialize(dr)
    @dr = dr
  end

  def kindergarten_participation_rate_variation(district_1, district_2)
    district1 = district_1_kinder_avg(district_1)

    district2 = district_2_kinder_avg(district_2)

    variation = (district1/district2).round(3)
  end

   def district_1_kinder_avg(district)
     dr.find_by_name(district).calculate_kinder_average
   end

   def district_2_kinder_avg(district)
     dr.find_by_name(district[:against]).calculate_kinder_average
   end

  def kindergarten_participation_rate_variation_trend(district_1, district_2)
    district_trend = Hash.new

    district1 = district_1_kinder_participation(district_1)
    district2 = district_2_kinder_state_participation(district_2)

    district1.each do |year, participation|
      district_trend[year.to_i] = (district1[year].to_f/ district2[year].to_f).round(3)
    end
    district_trend
  end

  def district_1_kinder_participation(district)
    dr.find_by_name(district).enrollment.kindergarten_participation
  end

  def district_2_kinder_state_participation(district)
    dr.find_by_name(district[:against]).enrollment.kindergarten_participation
  end

  def kindergarten_against_high_school_graduation(district)
  #   high_school_enrollment = enrollment.find_by_name(district)
  #   binding.pry
  #   puts high_school_enrollment
  end

  def hs_1_grad_average(district)
    dr.find_by_name(district).calculate_hs_grad_average
  end

  def hs_2_grad_average(district)
    dr.find_by_name(district[:against]).calculate_hs_grad_average
  end

  def high_school_graduation_variation(district_1, district_2)
    hs_1 = hs_1_grad_average(district_1)

    hs_2 = hs_2_grad_average(district_2)

    variation = (hs_1/hs_2).round(3)
  end

  # def find_by_name(name)
  #   if name.nil?
  #     nil
  #   else
  #     data = enrollments.find do |element|
  #      element[1].name.downcase == name.downcase
  #     end
  #     data && data[1]
  #   end
  # end

    # kindergarten_variation = kindergarten_participation_rate_variation(district, :against => 'COLORADO')
     #dividing kinder participation by statwide
    #  graduation_variation = kindergarten_participation_rate_variation(district, :against => 'COLORADO')
    #  divide the districts grad rate by state avg.

end
