require "minitest/autorun"
require "minitest/pride"
require "pry"
require "statewide_test"

class StatewideTestRepositoryTest < MiniTest::Test

  def fixture_path_3rd
    File.expand_path("3rd grade students scoring proficient or above on the CSAP_TCAP.csv", __dir__)
  end

  def fixture_path_8th
    File.expand_path("8th grade students scoring proficient or above on the CSAP_TCAP.csv", __dir__)
  end

  def fixture_path_math
    File.expand_path("Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv", __dir__)
  end

  def fixture_path_reading
    File.expand_path("Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv", __dir__)
  end

  def fixture_path_writing
    File.expand_path("Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv", __dir__)
  end

  def sr
    @sr ||= begin
      sr = StatewideTestRepository.new
      sr.load_data({
        :statewide_testing => {
          :third_grade => fixture_path_3rd,
          :eighth_grade => fixture_path_8th,
          :math => fixture_path_math,
          :reading => fixture_path_reading,
          :writing => fixture_path_writing
        }
      })
      sr
    end
  end

  def test_it_can_find_a_statewide_testing_object
    assert_kind_of StatewideTestRepository.new, sr.find_by_name("ACADEMY 20")
  end

  def test_it_does_not_generate_new_objects_using_find
    skip
    statewide_test = sr.find_by_name("ACADEMY 20")
    assert_equal(er.find_by_name("ACADEMY 20").object_id, enrollment.object_id)
  end

  def test_it_finds_by_name
    skip
    statewide_test = sr.find_by_name("ACADEMY 20")
    assert_equal("ACADEMY 20", statewide_test.name)
  end

end
