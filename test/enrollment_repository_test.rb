require "minitest/autorun"
require "minitest/pride"
require "enrollment_repository"
require "pry"
require "enrollment"

class EnrollmentRepositoryTest < Minitest::Test
  def kindergarten_participation_access_hash
    path = File.expand_path("fixtures/Kindergartners in full-day program.csv", __dir__)
    
    { :kindergarten_participation => path }
    
  end

  def hs_graduation_rate_access_hash
    path = File.expand_path("fixtures/High school graduation rates.csv", __dir__)

    { :high_school_graduation_rates => path }
  end

  def setup
    file_paths = [kindergarten_participation_access_hash, hs_graduation_rate_access_hash]

    @enrollment_repository ||= begin
      enrollment_repository = EnrollmentRepository.new
      enrollment_repository.load_data(file_paths)
      enrollment_repository
    end
  end

  def teardown
    @enrollment_repository = nil
  end

  def test_it_can_find_an_enrollment_object
    assert_kind_of Enrollment, @enrollment_repository.find_by_name("ACADEMY 20")
  end

  def test_it_does_not_generate_new_objects_using_find
    enrollment = @enrollment_repository.find_by_name("ACADEMY 20")

    assert_equal(@enrollment_repository.find_by_name("ACADEMY 20").object_id, enrollment.object_id)
  end

  def test_it_finds_by_name
    enrollment = @enrollment_repository.find_by_name("ACADEMY 20")

    assert_equal("ACADEMY 20", enrollment.name)
  end

  def test_it_finds_truncated_participation_data
    expected_kindergarten_participation = 
                  { 2007 => 0.391, 2006 => 0.353, 2005 => 0.267,
                   2004 => 0.302, 2008 => 0.384, 2009 => 0.39,
                   2010 => 0.436, 2011 => 0.489, 2012 => 0.478,
                   2013 => 0.487, 2014 => 0.490 }

    enrollment = @enrollment_repository.find_by_name("ACADEMY 20")

    assert_equal(expected_kindergarten_participation, enrollment.kindergarten_participation)
  end

  def test_find_by_name_is_not_case_sensitive
    enrollment = @enrollment_repository.find_by_name("coloRADo")

    assert_equal("Colorado", enrollment.name)
  end

  def test_find_by_name_returns_nil_for_no_input
    enrollment = @enrollment_repository.find_by_name(nil)

    assert_equal(nil, enrollment)
  end

  def test_find_by_name_returns_nil_with_random_special_characters
    enrollment = @enrollment_repository.find_by_name("Colo*!^*@#rado")

    assert_equal(nil, enrollment)
  end

  def test_graduation_rate_by_year
    expected_grad_rate = {2010=>0.57, 2011=>0.608, 2012=>0.633, 2013=>0.593, 2014=>0.659}
    enrollment = @enrollment_repository.find_by_name("ADAMS COUNTY 14")

    assert_equal expected_grad_rate, enrollment.high_school_graduation_rates
  end

  def test_graduation_rate_in_year
    enrollment = @enrollment_repository.find_by_name("ADAMS COUNTY 14")
    
    assert_equal 0.57, enrollment.high_school_graduation_rates[2010]
  end
end
