require 'minitest/autorun'
require 'minitest/pride'
require '../lib/district_repository'
require 'pry'

class DistrictRepositoryTest < Minitest::Test

  def test_does_it_have_a_class
    dr = DistrictRepository.new
    assert DistrictRepository.class
  end

  def test_does_repository_exist
    dr = DistrictRepository.new
    assert dr
  end

  def test_load_data
    dr = DistrictRepository.new
    dr.runner
    refute dr.districts.empty?
  end
end
