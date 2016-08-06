require "minitest/autorun"
require "minitest/pride"
require_relative "./../lib/district_repository"
require "pry"

class DistrictRepositoryTest < Minitest::Test
  def fixture_path
    File.expand_path("fixtures/Kindergartners in full-day program.csv", __dir__)
  end

  def setup
    @district_repository ||= begin
      district_repository = DistrictRepository.new

      district_repository.load_data(fixture_path)
       district_repository
    end
  end

  def teardown
    @district_repository = nil
  end

  def test_does_repository_exist
    assert @district_repository
    assert DistrictRepository.class
  end

  def test_load_data
    refute @district_repository.districts.empty?
  end

  def test_is_there_a_find_by_name_method
    assert @district_repository.respond_to?(:find_by_name)
  end

  def test_is_there_a_find_all_districts_matching_name_fragment_method
    assert @district_repository.respond_to?(:find_all_districts_matching_name_fragment)
  end

  def test_find_by_name_returns_district
    assert_equal "ACADEMY 20", @district_repository.find_by_name("ACADEMY 20").name
  end

  def test_find_by_name_works_with_different_district
    assert_equal "ADAMS COUNTY 14", @district_repository.find_by_name("ADAMS COUNTY 14").name
  end

  def test_does_it_return_the_name_capitalized
    assert_equal "ACADEMY 20", @district_repository.find_by_name("academy 20").name
  end

  def test_can_it_find_a_name_with_trailing_white_space
    assert_equal "ACADEMY 20", @district_repository.find_by_name(" academy 20 ").name
  end

  def test_does_find_by_name_return_with_nil
    assert_equal nil, @district_repository.find_by_name("Zombocom")
  end

  def test_does_find_by_name_work_with_no_input
    assert_equal nil, @district_repository.find_by_name("")
  end

  def test_does_find_by_name_work_with_special_characters
    assert_equal nil, @district_repository.find_by_name("zom--bo-*com")
  end

  def test_does_find_all_districts_matching_name_fragment_return_all_cases
    matched_objects = @district_repository.find_all_districts_matching_name_fragment("AGATE 300")
    matched_names = matched_objects.map(&:name)
    assert_equal ["AGATE 300"], matched_names
  end

  def test_does_find_all_districts_matching_name_fragment_with_name_fragments_return_values
    matched_objects = @district_repository.find_all_districts_matching_name_fragment("AGA")
    matched_names = matched_objects.map(&:name)
    assert_equal ["AGATE 300"], matched_names
  end

  def test_does_find_all_districts_matching_name_fragment_work_case_insensitive_for_one_result
    matched_objects = @district_repository.find_all_districts_matching_name_fragment("aga")
    matched_names = matched_objects.map(&:name)
    assert_equal ["AGATE 300"], matched_names
  end

  def test_does_find_all_districts_matching_name_fragment_work_with_no_input
    assert_equal [], @district_repository.find_all_districts_matching_name_fragment("  ")
  end

  def test_does_find_all_districts_matching_name_fragment_work_with_case_for_multiple_results
    matched_objects = @district_repository.find_all_districts_matching_name_fragment("cen")
    matched_names = matched_objects.map(&:name)
    assert_equal ["CENTENNIAL R-1", "CENTER 26 JT"], matched_names
  end
end
