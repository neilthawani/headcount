require "minitest/autorun"
require "minitest/pride"
require "enrollment"

class EnrollmentTest < Minitest::Test
  def setup
    @enrollment ||= begin
      enrollment = Enrollment.new(name: "ACADEMY 20",
                                  kindergarten_participation: {
                                  2010 => 0.3915,
                                  2011 => 0.35356,
                                  2012 => 0.1234 })
      enrollment
    end
  end

  def teardown
    @enrollment = nil
  end

  def expected_kinder_participation_data
    {2010 => 0.3915,
      2011 => 0.35356,
      2012 => 0.1234}
  end

  def test_we_can_create_an_instance
    assert_equal "ACADEMY 20", @enrollment.name
  end

  def test_it_can_get_kindergarten_participation
    assert_equal(expected_kinder_participation_data, @enrollment.kindergarten_participation)
  end

  def test_it_can_get_kindergarten_participation_by_year
    assert_equal(0.3915, @enrollment.kindergarten_participation[2010])
  end

  def test_it_returns_nil_for_participation_by_year_by_year_that_does_not_exist
    assert_equal(nil, @enrollment.kindergarten_participation[2009])
  end
end
