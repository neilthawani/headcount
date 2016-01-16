require_relative 'district_repository'
require_relative 'enrollment'

class HeadcountAnalyst
  def initialize(dr)
  end

  def dr
    DistrictRepository.new
  end

  def kindergarten_participation_rate_variation(district_1, district_2)
    district1 =  dr.find_by_name(district_1).calculate_kinder_average

    district2 =  dr.find_by_name(district_2[:against]).calculate_kinder_average
    (district1/district2).round(3)
  end
end

#I want to find the district academy 20
#I then want to find the district colorado
#I then want to compare their enrollment rates
#with that data I want to return the district average divided by states average(all years)
