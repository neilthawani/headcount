require_relative 'district_repository'
require_relative 'enrollment'
require 'pry'

class HeadcountAnalyst
  def initialize(dr)
  end

  def dr
    DistrictRepository.new
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
end
