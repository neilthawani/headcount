require "minitest/autorun"
require "minitest/pride"
require "district"

class DistrictTest < Minitest::Test
  def test_can_we_pass_in_a_name
    district = District.new(name: "ACADEMY 20")
    assert_equal "ACADEMY 20", district.name
  end
end
