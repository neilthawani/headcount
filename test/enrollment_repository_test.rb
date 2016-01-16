require "minitest/autorun"
require "minitest/pride"
require "enrollment_repository"
require "pry"

class EnrollmentRepositoryTest < Minitest::Test
  def fixture_path
    File.expand_path("fixtures/Kindergartners in full-day program.csv", __dir__)
  end

  def er
    @er ||= begin
      er = EnrollmentRepository.new
      er.load_data(enrollment: { kindergarten: fixture_path })
      er
    end
  end

  def test_it_can_find_an_enrollment_object
    assert_kind_of Enrollment, er.find_by_name("ACADEMY 20")
  end
 
  def test_it_does_not_generate_new_objects_using_find
    enrollment = er.find_by_name("ACADEMY 20")
    assert_equal(er.find_by_name("ACADEMY 20").object_id, enrollment.object_id)
  end

  def test_it_finds_by_name
    enrollment = er.find_by_name("ACADEMY 20")
    assert_equal("ACADEMY 20", enrollment.name)
  end

  def test_it_finds_truncated_participation_data
    enrollment = er.find_by_name("ACADEMY 20")
    assert_equal({ "2007" => "0.391", "2006" => "0.353", "2005" => "0.267",
                   "2004" => "0.302", "2008" => "0.384", "2009" => "0.39",
                   "2010" => "0.436", "2011" => "0.489", "2012" => "0.478",
                   "2013" => "0.487", "2014" => "0.490" },
                 enrollment.kindergarten_participation)
  end

  def test_it_is_not_case_sensitive_for_search
    enrollment = er.find_by_name("coloRADo")
    assert_equal("Colorado", enrollment.name)
  end

  def test_it_returns_nil_for_empty_input
    enrollment = er.find_by_name("")
    assert_equal(nil, enrollment)
  end

  def test_it_returns_nil_with_random_special_characters
    enrollment = er.find_by_name("Colo*!^*@#rado")
    assert_equal(nil, enrollment)
  end
end
