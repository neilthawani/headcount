require "csv"
require "pry"
require_relative "enrollment"

class EnrollmentRepository
  attr_accessor :enrollment

  def initialize
  end

  def load_data(data)
    self.enrollment = Enrollment.new(name: "enrollment")
  end

  def find_by_name(name)
    enrollment
  end
end
