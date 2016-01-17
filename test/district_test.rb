require "minitest/autorun"
require "minitest/pride"
require "district"

class DistrictTest < Minitest::Test
  def test_can_we_pass_in_a_name
    d = District.new(name: "ACADEMY 20")
    assert_equal "ACADEMY 20", d.name
  end
end










#4:30 erenna
#deb + adrienne
#deb work on assessment
#sunny work on assessment
#deb + allan whiteboard
#sunny work on portfolio/feedback
#deb work on portfolio/feedback
