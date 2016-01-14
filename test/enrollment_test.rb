require "minitest/autorun"
require "minitest/pride"
require "../lib/enrollment"

class EnrollmentTest < Minitest::Test
  def test_has_a_class
    assert Enrollment.new
  end
end
