require_relative 'district_repository'
require_relative 'enrollment'

class HeadcountAnalyst

  def initialize(dr)
  end

  def dr
    DistrictRepository.new
  end


  def kindergarten_participation_rate_variation(name, comparison)
    district =  dr.find_by_name(name)
    district.kindergarten_participation

    # require "pry"; binding.pry
  end
end

#I want to find the district academy 20
#I then want to find the district colorado
#I then want to compare their enrollment rates
#with that data I want to return the district average divided by states average(all years)
