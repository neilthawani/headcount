require "minitest/autorun"
require "minitest/pride"
require "enrollment"

class EnrollmentTest < Minitest::Test
  def enrollment
    @enrollment ||= begin
      enrollment = Enrollment.new(name: "ACADEMY 20",
                                  kindergarten_participation: {
                                  2010 => 0.3915,
                                  2011 => 0.35356,
                                  2012 => 0.1234 })
      enrollment
    end
  end

  def test_we_can_create_an_instance
    kindergarten_participation = {2010 => 0.3915,
                                  2011 => 0.35356,
                                  2012 => 0.1234}
                                  
    assert_equal "ACADEMY 20", enrollment.name

    assert_equal(kindergarten_participation, enrollment.kindergarten_participation)
  end

  def test_it_can_get_kindergarten_participation_by_year
    kindergarten_participation = {2010 => 0.3915,
                                  2011 => 0.35356,
                                  2012 => 0.1234}

    assert_equal(kindergarten_participation, enrollment.kindergarten_participation)
  end

  def test_it_can_get_kindergarten_participation_by_year_by_year
    assert_equal(0.3915, enrollment.kindergarten_participation[2010])
  end

  def test_it_returns_nil_for_participation_by_year_by_year_that_does_not_exist
    assert_equal(nil, enrollment.kindergarten_participation[2009])
  end
end
