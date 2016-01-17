require "csv"
require "pry"
require_relative "enrollment"
require_relative "district"

class EnrollmentRepository
  attr_accessor :enrollments

  def initialize
    @enrollments = []
  end

  def load_data(data)
    collection = Hash.new
    CSV.foreach(data[:enrollment][:kindergarten] || data[:enrollment][:high_school_graduation_rates],
                headers: true, header_converters: :symbol) do |row|
      collection[row[:location]] ||= Hash.new
      collection[row[:location]][row[:timeframe].to_i] = row[:data][0..4].to_f
    end
    collection.map do |location, data|
      if data.count <= 5
        enrollments << Enrollment.new(name: location,
                                             high_school_graduation_rates: data)
      else
        enrollments << Enrollment.new(name: location,
                                             kindergarten_participation: data)
      end
    end
  end

  def find_by_name(name)
    enrollments.detect do |element|
    element.name.downcase == name.downcase
    end
  end
end
