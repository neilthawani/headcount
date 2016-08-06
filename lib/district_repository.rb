require "csv"
require_relative "enrollment_repository"

class DistrictRepository
  attr_reader :districts, :enrollment

  def initialize
    @districts = {}

    # make enrollment repo
    file_paths = [kindergarten_participation_access_hash,
                  hs_graduation_rate_access_hash]

    @enrollment_repository = EnrollmentRepository.new
    @enrollment_repository.load_enrollment_data(file_paths)
  end

  def find_by_name(name)
    pair = districts.detect do |_key, value|
      name.strip.upcase == value.name.upcase
    end

    pair && pair[1]
  end

  def find_all_districts_matching_name_fragment(name_fragment)
    matching = districts.select do |_key, value|
      value.name.upcase.include?(name_fragment.upcase)
    end

    matching.values
  end

  def kindergarten_participation_access_hash
    path = "data/Kindergartners in full-day program.csv"
    { :kindergarten_participation => path }
  end

  def hs_graduation_rate_access_hash
    path = "data/High school graduation rates.csv"
    { :high_school_graduation_rates => path }
  end

  def load_district_data(kindergarten_csv_path)
    contents = CSV.open(kindergarten_csv_path,
                        headers: true,
                        header_converters: :symbol)

    # set class variable of type hash "districts" to
    # key: district's name.to_sym,
    # value: district object with name instance var set
    contents.each do |row|
      district = row[:location]

      districts[district.to_sym] = District.new(name: district)
    end

    # iterate through each district and 
    # fetch its data from the enrollment repo
    # set each object in the districts collection's enrollment_data
    districts.each do |district_name, district|
      enrollment = @enrollment_repository.find_by_name(district.name)
      district.send("enrollment_data=", enrollment)
    end
  end
end