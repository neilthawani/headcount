require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative "../lib/district_repository"
require_relative "../lib/enrollment_repository"

class IterationOneTest < Minitest::Test
  attr_reader :dr

  def fixture_path
    File.expand_path("fixtures/Kindergartners in full-day program.csv", __dir__)
  end

  def setup
    @dr ||= begin
      dr = DistrictRepository.new
      dr.load_data({
        :enrollment => {
          :kindergarten => fixture_path
        }
       })
       dr
    end
  end

 meta single: true
  def test_starting_relationship_layer
    setup
    district = dr.find_by_name("ACADEMY 20")
    # dr.make_a_enrollment_repo
    # dr.send_enrollments_out
    enrollment = district.enrollment
    assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
  end
end
