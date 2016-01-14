require "minitest/autorun"
require "minitest/pride"
require "../lib/enrollment_repository"
require "pry"

class EnrollmentRepositoryTest < Minitest::Test
  def test_it_can_find_an_enrollment_object
    er = EnrollmentRepository.new
    er.load_data({
      enrollment: {
        kindergarten: "./fixtures/Kindergartners in full-day program.csv"
      }
    })
    enrollment = er.find_by_name("ACADEMY 20")

    assert_kind_of(Enrollment, enrollment)
  end

  def test_it_does_not_generate_new_objects_using_find
    er = EnrollmentRepository.new
    er.load_data({
      enrollment: {
        kindergarten: "./fixtures/Kindergartners in full-day program.csv"
      }
    })
    enrollment = er.find_by_name("ACADEMY 20")

    assert_equal(er.find_by_name("ACADEMY 20").object_id, enrollment.object_id)
  end

  def test_it_finds_by_name
    er = EnrollmentRepository.new
    er.load_data({
      enrollment: {
        kindergarten: "./fixtures/Kindergartners in full-day program.csv"
      }
    })
    enrollment = er.find_by_name("ACADEMY 20")

    assert_equal("ACADEMY 20", enrollment.name)
  end
end
