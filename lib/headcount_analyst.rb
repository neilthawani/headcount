
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

  def kindergarten_participation_against_high_school_graduation(district, hash = {against: "COLORADO"})

    kinder_variation = kindergarten_participation_rate_variation(district, hash)

    grad_variation = high_school_graduation_variation(district, hash)

    kinder_grad_variance = (kinder_variation/grad_variation).round(3)
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

  def kindergarten_participation_correlates_with_high_school_graduation(for_hash, hash = {against: "COLORADO"})
    if for_hash[:for] == 'STATEWIDE'
      statewide(hash)
    elsif for_hash[:across].class == Array
      subset_of_districts(for_hash, hash)
    else
      does_it_correlate = high_school_graduation_variation(for_hash[:for], hash)
      does_it_correlate.between?(0.6,1.5)
    end
  end

  def subset_of_districts(for_hash, hash)
    districts_to_test = for_hash[:across]
    x = districts_to_test.map do |district|
      variations = high_school_graduation_variation(district, hash)
      variations.between?(0.6,1.5)
    end
    if x.count(true)/x.count > 0.700
      true
    else
      false
    end
  end

  def statewide(hash)
    all_districts = dr.districts.map do |key, value|
      district_in_string = value.name
      high_school_graduation_variation(district_in_string, hash)
    end
    if (all_districts.reduce(:+)/all_districts.count).round(3) >= 0.700
      true
    else
      false
    end
  end
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
