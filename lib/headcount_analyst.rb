class HeadcountAnalyst
  attr_reader :district_repository

  def initialize(district_repository)
    @district_repository = district_repository
  end

  def kindergarten_participation_rate_variation(district_1, district_2)
    district1 = district_kinder_avg(district_1)

    district2 = district_kinder_avg(district_2)

    variation = (district1/district2).round(3)
  end

  def district_kinder_avg(district)
    district_repository.find_by_name(district).calculate_field_average(:kindergarten_participation)
  end

  def kindergarten_participation_rate_variation_trend(district_1, district_2)
    district_trend = Hash.new

    district1 = district_kinder_participation(district_1)
    district2 = district_kinder_participation(district_2)

    district1.each do |year, participation|
      district_trend[year.to_i] = (district1[year].to_f / district2[year].to_f).round(3)
    end
    district_trend
  end

  def district_kinder_participation(district)
    district_repository.find_by_name(district).enrollment_data.kindergarten_participation
  end

  def kindergarten_participation_against_high_school_graduation(for_district, against_district = "COLORADO")
    kinder_variation = kindergarten_participation_rate_variation(for_district, against_district)

    grad_variation = high_school_graduation_variation(for_district, against_district)

    kinder_grad_variance = (kinder_variation/grad_variation).round(3)
  end

  def high_school_graduation_variation(district_1, district_2)
    hs_1 = hs_grad_average(district_1)

    hs_2 = hs_grad_average(district_2)

    variation = (hs_1/hs_2).round(3)
  end

  def hs_grad_average(district)
    district_repository.find_by_name(district).calculate_field_average(:high_school_graduation_rates)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(for_district, against_district = "COLORADO")
    does_it_correlate = high_school_graduation_variation(for_district, against_district)
    does_it_correlate.between?(0.6,1.5)
  end

  def kindergarten_participation_correlates_with_high_school_graduation_across_subset_of_districts(across_array, against_district)
    x = across_array.map do |district|
      kindergarten_participation_correlates_with_high_school_graduation(district, against_district)
    end

    if x.count(true)/x.count > 0.700
      true
    else
      false
    end
  end

  def statewide_kindergarten_participation_correlates_with_hs_graduation(hash)
    does_correlate = false
    all_districts = district_repository.districts.map do |key, value|
      district_in_string = value.name
      high_school_graduation_variation(district_in_string, hash)
    end

    if (all_districts.reduce(:+)/all_districts.count).round(3) >= 0.700
      does_correlate = true
    end

    does_correlate
  end
end
