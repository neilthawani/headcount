require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative "../lib/district_repository"
require_relative "../lib/enrollment_repository"

class IterationOneTest < Minitest::Test
  attr_reader :district_repository

  def fixture_path
    File.expand_path("fixtures/Kindergartners in full-day program.csv", __dir__)
  end

  def setup
    @district_repository ||= begin
      district_repository = DistrictRepository.new
      district_repository.load_data({
        :enrollment => {
          :kindergarten => fixture_path
        }
       })
       district_repository
    end
  end

  def test_starting_relationship_layer
    district = district_repository.find_by_name("ACADEMY 20")
    assert_equal 0.436, district.enrollment.kindergarten_participation[2010]
  end

end
