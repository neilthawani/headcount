require "csv"
require_relative "enrollment_repository"

class DistrictRepository
  attr_reader :districts, :enrollment_repository, :enrollment

  def initialize
    @districts = {}
  end

  def find_by_name(name)
    pair = districts.detect do |_key, value|
      name.strip.upcase == value.name.upcase
    end

    pair && pair[1]
  end

  def find_all_matching(name_fragment)
    matching = districts.select do |_key, value|
      value.name.upcase.include?(name_fragment.upcase)
    end

    matching.values
  end

  def parser(contents)
    contents.each do |row|
      district = row[:location]

      districts[district.to_sym] = District.new(name: district)
    end
  end

  def send_enrollments_out
    districts.each do |district_name, district|
      enrollment = enrollment_repository.find_by_name(district.name)
      district.send("enrollment_data=", enrollment)
    end
  end

  def kindergarten_participation_access_hash
    path = "data/Kindergartners in full-day program.csv"
    { :kindergarten_participation => path }
  end

  def hs_graduation_rate_access_hash
    path = "data/High school graduation rates.csv"
    { :high_school_graduation_rates => path }
  end

  def make_a_enrollment_repo
    file_paths = [kindergarten_participation_access_hash,
                  hs_graduation_rate_access_hash]

    @enrollment_repository = EnrollmentRepository.new
    enrollment_repository.load_data(file_paths)
  end

  def load_data(kindergarten_csv_path)
    contents = CSV.open(kindergarten_csv_path,
                        headers: true,
                        header_converters: :symbol)

    parser(contents)
    make_a_enrollment_repo
    send_enrollments_out
  end
end
