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

  def test_starting_relationship_layer
    district = dr.find_by_name("ACADEMY 20")
    assert_equal 0.436, district.enrollment.kindergarten_participation[2010]
  end

end
