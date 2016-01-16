require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/headcount_analyst'

class HeadCountAnalystTest < Minitest::Test

  def test_head_analyst_initialized_with_district_repo
    dr = DistrictRepository.new
    ha = HeadcountAnalyst.new(dr)
    
  end

end
