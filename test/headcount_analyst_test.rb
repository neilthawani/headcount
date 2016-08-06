require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/headcount_analyst'
require_relative '../lib/district_repository'

class HeadCountAnalystTest < Minitest::Test
  def kindergarten_data_fixture_path
    File.expand_path("fixtures/Kindergartners in full-day program.csv", __dir__)
  end

  def district_repository
    @district_repository ||= begin
      district_repository = DistrictRepository.new
      district_repository.load_data(kindergarten_data_fixture_path)
       district_repository
    end
  end

  def headcount_analyst
    headcount_analyst = HeadcountAnalyst.new(district_repository)
  end

  def setup
    @district_repository = district_repository
    @headcount_analyst = headcount_analyst
  end

  def teardown
    @district_repository = nil
    @headcount_analyst = nil
  end

  def test_head_analyst_exists
    assert @headcount_analyst
  end

  def test_does_head_analyst_init_with_district_repo
    assert_kind_of DistrictRepository, @headcount_analyst.district_repository
  end

  def test_if_kidergarten_participation_avg_compares_to_state_average
    assert_equal 0.766, @headcount_analyst.calculate_district_data_variation('ACADEMY 20', 'COLORADO', :kindergarten_participation)
  end

  def test_if_kidergarten_participation_compares_to_another_district
    assert_equal 0.573, @headcount_analyst.calculate_district_data_variation('ACADEMY 20', 'ADAMS COUNTY 14', :kindergarten_participation)
  end

  def test_if_kidergarten_participation_rate_trends_against_state_average
    district_trend = {2007=>0.992, 2006=>1.051, 2005=>0.96, 2004=>1.258, 2008=>0.718, 2009=>0.652, 2010=>0.681, 2011=>0.728, 2012=>0.688, 2013=>0.694, 2014=>0.661}

    assert_equal district_trend, @headcount_analyst.kindergarten_participation_rate_variation_trend('ACADEMY 20', 'COLORADO')
  end

  def test_if_hs_graduation_avg_compares_to_state_average
    assert_equal 1.194, @headcount_analyst.calculate_district_data_variation("ACADEMY 20", 'COLORADO', :high_school_graduation_rates)
  end

  def test_does_kindergarten_participation_affect_hs_graduation
    assert_equal 0.642, @headcount_analyst.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
  end

  def test_does_kinder_participation_correlate
    assert_equal true, @headcount_analyst.does_kindergarten_participation_correlate_with_high_school_graduation('ACADEMY 20')
  end

  def test_do_statewide_percentages_correlate_with_grad_rates
    assert_equal true, @headcount_analyst.statewide_kindergarten_participation_correlates_with_hs_graduation('COLORADO')
  end

  def test_does_kinder_participation_correlate_with_a_subset_of_districts
    districts = ['ACADEMY 20','ADAMS COUNTY 14', 'ADAMS-ARAPAHOE 28J', 'AGUILAR REORGANIZED 6']
    
    assert_equal true, @headcount_analyst.kindergarten_participation_correlates_with_high_school_graduation_across_subset_of_districts(districts, "COLORADO")
  end
end
