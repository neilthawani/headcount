require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/district_repository"

class IterationOneTest < Minitest::Test
  def kindergarten_data_fixture_path
    File.expand_path("fixtures/Kindergartners in full-day program.csv", __dir__)
  end

  def setup
    @district_repository ||= begin
      district_repository = DistrictRepository.new
      district_repository.load_district_data(kindergarten_data_fixture_path)
       district_repository
    end
  end

  def teardown
    @district_repository = nil
  end

  def test_starting_relationship_layer
    district = @district_repository.find_by_name("ACADEMY 20")
    assert_equal 0.436, district.enrollment_data.kindergarten_participation[2010]
  end
end