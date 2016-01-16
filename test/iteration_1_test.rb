require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative "../lib/district_repository"
require_relative "../lib/enrollment_repository"

class IterationOneTest < Minitest::Test
  def test_starting_relationship_layer
    dr = DistrictRepository.new
    district = dr.find_by_name("ACADEMY 20")
    enrollment = district.enrollment
    assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
  end
end
