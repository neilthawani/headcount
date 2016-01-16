require "minitest/autorun"
require "minitest/pride"
require "enrollment"

class EnrollmentTest < Minitest::Test
  def test_we_can_create_an_instance
    enrollment = Enrollment.new(name: "ACADEMY 20",
                                kindergarten_participation: {
                                  2010 => 0.3915,
                                  2011 => 0.35356,
                                  2012 => 0.1234 },
                               )
    assert_equal "ACADEMY 20", enrollment.name
    assert_equal({ 2010 => 0.3915, 2011 => 0.35356, 2012 => 0.1234 },
    enrollment.kindergarten_participation)
  end

  def test_it_can_get_kindergarten_participation_by_year
    enrollment = Enrollment.new(name: "ACADEMY 20",
                                kindergarten_participation: {
                                  2010 => 0.3915,
                                  2011 => 0.35356,
                                  2012 => 0.1234            },
                               )
    assert_equal({
      2010 => 0.3915,
      2011 => 0.35356,
      2012 => 0.1234
                 }, enrollment.kindergarten_participation_in_year)
  end

  def test_it_can_get_kindergarten_participation_by_year_by_year
    enrollment = Enrollment.new(name: "ACADEMY 20",
                                kindergarten_participation: {
                                  2010 => 0.3915,
                                  2011 => 0.35356,
                                  2012 => 0.1234 },
                               )
    assert_equal(0.3915, enrollment.kindergarten_participation_in_year(2010))
  end

  def test_it_returns_nil_for_participation_by_year_by_year_that_dne
    enrollment = Enrollment.new(name: "ACADEMY 20",
                                kindergarten_participation: {
                                  2010 => 0.3915,
                                  2011 => 0.35356,
                                  2012 => 0.1234 },
                               )
    assert_equal(nil, enrollment.kindergarten_participation_in_year(2009))
  end
end
