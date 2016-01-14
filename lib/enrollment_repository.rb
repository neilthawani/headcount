require "csv"
require "pry"
require_relative "enrollment"

class EnrollmentRepository
  attr_accessor :enrollments

  def initialize
    @enrollments = []
  end

  def load_data(data)
    collection = Hash.new
    CSV.foreach(data[:enrollment][:kindergarten],
                headers: true, header_converters: :symbol) do |row|
      collection[row[:location]] = Hash.new
      collection[row[:location]][row[:timeframe]] = row[:data]
    end
    collection.map do |location, data|
      self.enrollments << Enrollment.new(name: location,
                                         kindergarten_participation: data)
    end
  end

  def find_by_name(name)
    self.enrollments.find do |element|
      element.name == name
    end
  end
end
