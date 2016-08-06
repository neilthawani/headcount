require "minitest/autorun"
require "minitest/pride"
require "enrollment_repository"
require "pry"
require "enrollment"

class EnrollmentRepositoryTest < Minitest::Test
  def fixture_path  
    File.expand_path("fixtures/Kindergartners in full-day program.csv", __dir__)
  end

  def fixture_path_high_school
    File.expand_path("fixtures/High school graduation rates.csv", __dir__)
  end

  def enrollment_repository
    @enrollment_repository ||= begin
      enrollment_repository = EnrollmentRepository.new
      enrollment_repository.load_data({
        :enrollment => {
          :kindergarten => fixture_path,
          :high_school_graduation => fixture_path_high_school
        }
      })
      enrollment_repository
    end
  end
  def test_it_can_find_an_enrollment_object
    assert_kind_of Enrollment, enrollment_repository.find_by_name("ACADEMY 20")
  end

  def test_it_does_not_generate_new_objects_using_find
    enrollment = enrollment_repository.find_by_name("ACADEMY 20")
    assert_equal(enrollment_repository.find_by_name("ACADEMY 20").object_id, enrollment.object_id)
  end

  def test_it_finds_by_name
    enrollment = enrollment_repository.find_by_name("ACADEMY 20")
    assert_equal("ACADEMY 20", enrollment.name)
  end

  def test_it_finds_truncated_participation_data
    enrollment = enrollment_repository.find_by_name("ACADEMY 20")
    assert_equal({ 2007 => 0.391, 2006 => 0.353, 2005 => 0.267,
                   2004 => 0.302, 2008 => 0.384, 2009 => 0.39,
                   2010 => 0.436, 2011 => 0.489, 2012 => 0.478,
                   2013 => 0.487, 2014 => 0.490 },
                 enrollment.kindergarten_participation)
  end

  def test_it_is_not_case_sensitive_for_search
    enrollment = enrollment_repository.find_by_name("coloRADo")
    assert_equal("Colorado", enrollment.name)
  end

  def test_it_returns_nil_for_no_input
    enrollment = enrollment_repository.find_by_name(nil)
    assert_equal(nil, enrollment)
  end

  def test_it_returns_nil_with_random_special_characters
    enrollment = enrollment_repository.find_by_name("Colo*!^*@#rado")
    assert_equal(nil, enrollment)
  end

  def test_graduation_rate_by_year
    enrollment = enrollment_repository.find_by_name("ADAMS COUNTY 14")
    grad_rate = {2010=>0.57, 2011=>0.608, 2012=>0.633, 2013=>0.593, 2014=>0.659}

    assert_equal grad_rate, enrollment.graduation_rate_by_year
  end

  def test_graduation_rate_in_year
    enrollment = enrollment_repository.find_by_name("ADAMS COUNTY 14")
    assert_equal 0.57, enrollment.graduation_rate_in_year(2010)
  end
end
