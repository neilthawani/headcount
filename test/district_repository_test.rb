require 'minitest/autorun'
require 'minitest/pride'
require '../lib/district_repository'
require 'pry'

class DistrictRepositoryTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
  end

  def test_does_it_have_a_class
    assert DistrictRepository.class
  end

  def test_does_repository_exist
    assert @dr
  end

  def test_load_data
    refute @dr.districts.empty?
  end

  def test_is_there_a_find_by_name_method
    assert @dr.respond_to?(:find_by_name)
  end

  def test_is_there_a_find_all_matching_method
    assert @dr.respond_to?(:find_all_matching)
  end

  def test_find_by_name_returns_district
    assert_equal "ACADEMY 20", @dr.find_by_name("ACADEMY 20")[1].name
  end

  def test_find_by_name_works_with_different_district
    assert_equal "ADAMS COUNTY 14", @dr.find_by_name("ADAMS COUNTY 14")[1].name
  end

  def test_does_it_capitalize
   assert_equal 'ACADEMY 20', @dr.find_by_name("academy 20")[1].name
  end

  def test_does_find_by_name_return_with_nil
   assert_equal nil, @dr.find_by_name("Zombocom")
  end

  def test_does_find_by_name_work_with_no_input
    assert_equal nil, @dr.find_by_name("")
  end

  def test_does_find_by_name_work_with_special_characters
    assert_equal nil, @dr.find_by_name("zom--bo-*com")
  end

  def test_does_find_all_matching_return_all_cases
     assert_equal ["AGATE 300"], @dr.find_all_matching("AGATE 300")
  end

  def test_does_find_all_matching_with_name_fragments_return_values
     assert_equal ["AGATE 300"], @dr.find_all_matching("AGA")
  end

  def test_does_find_all_matching_work_case_insensitive
     assert_equal ["AGATE 300"], @dr.find_all_matching("aga")
  end

  def test_does_find_all_matching_work_with_no_input
     assert_equal [], @dr.find_all_matching("  ")
  end

  def test_does_find_all_matching_work_with_case_insensitivity
     assert_equal ["Colorado", "COLORADO SPRINGS 11"], @dr.find_all_matching("col")
  end
end
