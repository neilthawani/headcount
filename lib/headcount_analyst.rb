class HeadcountAnalyst
  attr_reader :district_repository

  def initialize(district_repository)
    @district_repository = district_repository
  end

  def calculate_kinder_to_hs_retention_variation(district1_name, district2_name = "COLORADO")
    kindergarten_variation = calculate_data_variation(
                                district1_name,
                                district2_name,
                                :kindergarten_participation)

    high_school_variation = calculate_data_variation(
                                district1_name,
                                district2_name,
                                :high_school_graduation_rates)

    (kindergarten_variation / high_school_variation).round(3)
  end

  def calculate_data_variation(district1_name, district2_name, key)
    district1 = calculate_district_field_average(district1_name, key)
    district2 = calculate_district_field_average(district2_name, key)

    (district1 / district2).round(3)
  end

  def calculate_district_field_average(district, key)
    district_data = @district_repository.find_by_name(district)
    district_data.calculate_field_average(key)
  end

  def kindergarten_participation_rate_variation_trend(district1_name, district2_name)
    district_trend = Hash.new

    district1 = fetch_district_kindergarten_participation(district1_name)
    district2 = fetch_district_kindergarten_participation(district2_name)

    district1.each do |year, participation|
      district_trend[year.to_i] = (district1[year].to_f / district2[year].to_f).round(3)
    end

    district_trend
  end

  def fetch_district_kindergarten_participation(district_name)
    district = @district_repository.find_by_name(district_name)
    district.enrollment_data.kindergarten_participation
  end

  def does_kindergarten_participation_correlate_with_high_school_graduation(district1_name, district2_name = "COLORADO")
    does_it_correlate = calculate_data_variation(district1_name, district2_name, :high_school_graduation_rates)
    does_it_correlate.between?(0.6, 1.5)
  end

  def does_kindergarten_participation_correlate_with_high_school_graduation_across_subset_of_districts(across_array, against_district)
    x = across_array.map do |district|
      does_kindergarten_participation_correlate_with_high_school_graduation(district, against_district)
    end

    if (x.count(true) / x.count) > 0.700
      true
    else
      false
    end
  end

  def does_statewide_kindergarten_participation_correlate_with_district_hs_graduation(district2)
    does_correlate = false
    all_districts = @district_repository.districts.map do |key, value|
      district1 = value.name
      calculate_data_variation(district1, district2, :high_school_graduation_rates)
    end

    if (all_districts.reduce(:+)/all_districts.count).round(3) >= 0.700
      does_correlate = true
    end

    does_correlate
  end
end