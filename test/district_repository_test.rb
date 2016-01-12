require 'minitest/autorun'
require 'minitest/pride'
require '../lib/district_repository'
require 'pry'

class DistrictRepositoryTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
  end

  def test_does_it_have_a_class
    @dr
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
    @dr
    assert @dr.respond_to?(:find_all_matching)
  end

  def test_find_by_name
    assert_equal 'test', @dr.find_by_name("ASPEN 1")
  end



end
