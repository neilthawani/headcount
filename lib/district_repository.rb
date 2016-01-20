require "csv"
require "pry"
require_relative "district"
require_relative "enrollment_repository"

class DistrictRepository
  attr_reader :districts, :district_key, :er, :enrollment, :make_a_enrollment_repo, :send_enrollments_out

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
    # hey districts each of you line up and come here
      binding.pry
    districts.each do |district_name, district|

      # her district what's your name?
      #hey enrollment REpo, find me the Enrollment with this name
      enrollment = er.find_by_name(district.name)
    # I'm going to give you your enrollment object, and you have to keep it
      district.get_enrollment(enrollment)
    end
  end

  def make_a_enrollment_repo
    @er = EnrollmentRepository.new
      er.load_data({
        :enrollment => {
          :kindergarten => "test/fixtures/Kindergartners in full-day program.csv",
          :high_school_graduation => "test/fixtures/High school graduation rates.csv"
        }
      })
  end

  def load_data(district_data)
    kindergarten_csv = district_data.fetch(:enrollment).fetch(:kindergarten)
    contents = CSV.open kindergarten_csv, headers: true,
                                          header_converters: :symbol
    parser(contents)
  end
end
