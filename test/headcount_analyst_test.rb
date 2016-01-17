require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/headcount_analyst'
require_relative '../lib/district_repository'

class HeadCountAnalystTest < Minitest::Test

  def test_head_analyst_exists
    dr = DistrictRepository.new
    ha = HeadcountAnalyst.new(dr)

    assert ha
  end

  def test_does_head_analyst_init_with_district_repo
    dr = DistrictRepository.new
    ha = HeadcountAnalyst.new(dr)

    # assert_equal DistrictRepository, ha.dr.class
    assert_kind_of DistrictRepository, ha.dr
  end

  def test_returns_the_right_district_repo
    dr = DistrictRepository.new
    ha = HeadcountAnalyst.new(dr)

    assert_equal dr.find_by_name("ACADEMY 20").name, ha.dr.find_by_name("ACADEMY 20").name
  end

  def test_if_kidergarten_participation_compares_to_state_average

    dr = DistrictRepository.new
    ha = HeadcountAnalyst.new(dr)

    assert_equal 0.766, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end

  def test_if_kidergarten_participation_compares_to_another_district

    dr = DistrictRepository.new
    ha = HeadcountAnalyst.new(dr)

    assert_equal 0.573, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'ADAMS COUNTY 14')
  end

  def test_if_kidergarten_participation_rate_trends_against_state_average
    dr = DistrictRepository.new
    ha = HeadcountAnalyst.new(dr)
    district_trend = {2007=>0.992, 2006=>1.051, 2005=>0.96, 2004=>1.258, 2008=>0.718, 2009=>0.652, 2010=>0.681, 2011=>0.728, 2012=>0.688, 2013=>0.694, 2014=>0.661}

    assert_equal district_trend, ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  end

  def 

end
