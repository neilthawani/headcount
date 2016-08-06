class HeadcountAnalyst
  attr_reader :district_repository

  def initialize(district_repository)
    @district_repository = district_repository
  end

  def calculate_district_data_variation(district1_name, district2_name, key)
    district1 = calculate_district_field_average(district1_name, key)
    district2 = calculate_district_field_average(district2_name, key)
    
    (district1/district2).round(3)
  end

  def calculate_district_field_average(district, key)
    district_data = @district_repository.find_by_name(district)
    district_data.calculate_field_average(key)
  end

  def kindergarten_participation_rate_variation_trend(district1_name, district2_name)
    district_trend = Hash.new

    district1 = district_kinder_participation(district1_name)
    district2 = district_kinder_participation(district2_name)

    district1.each do |year, participation|
      district_trend[year.to_i] = (district1[year].to_f / district2[year].to_f).round(3)
    end

    district_trend
  end

  def district_kinder_participation(district)
    district_enrollment_data = @district_repository.find_by_name(district).enrollment_data
    district_enrollment_data.kindergarten_participation
  end

  def kindergarten_participation_against_high_school_graduation(for_district, against_district = "COLORADO")
    kinder_variation = calculate_district_data_variation(for_district, against_district, :kindergarten_participation)

    grad_variation = calculate_district_data_variation(for_district, against_district, :high_school_graduation_rates)

    kinder_grad_variance = (kinder_variation/grad_variation).round(3)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(for_district, against_district = "COLORADO")
    does_it_correlate = calculate_district_data_variation(for_district, against_district, :high_school_graduation_rates)
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

  def statewide_kindergarten_participation_correlates_with_hs_graduation(district2)
    does_correlate = false
    all_districts = @district_repository.districts.map do |key, value|
      district1 = value.name
      calculate_district_data_variation(district1, district2, :high_school_graduation_rates)
    end

    if (all_districts.reduce(:+)/all_districts.count).round(3) >= 0.700
      does_correlate = true
    end

    does_correlate
  end
end
