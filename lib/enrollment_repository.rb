require "csv"
require "pry"
require_relative "enrollment"

class EnrollmentRepository
  def initialize
    runner
  end

  def find_by_name
    # returns either nil or an instance of Enrollment having done a case of
    # insensitive search
  end

  def parser(contents)
    contents.each do |row|
      enrollment = row[:timeframe].to_i
      district = row[:location]
      new_enrollment = Enrollment.new(name: district,
                                      kindergarten_participation: enrollment)
      enrollments[enrollment.to_sym] = new_enrollment
      puts enrollment
    end
  end

  def load_data(enrollment_data)
    kindergarten_csv = enrollment_data[:enrollment][:kindergarten]
    contents = CSV.open kindergarten_csv, headers: true,
                                          header_converters: :symbol
    parser(contents)
  end

  def runner
    load_data(
      enrollment: {
        kindergarten: "../data/Kindergartners in full-day program.csv"
      },
    )
  end
end

EnrollmentRepository.new
