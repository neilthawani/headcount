require "minitest/autorun"
require "minitest/pride"
require "../lib/district"

class DistrictTest < Minitest::Test
  def test_can_we_pass_in_a_name
    d = District.new(name: "ACADEMY 20")
    assert_equal "ACADEMY 20", d.name
  end
end
