require "csv"
require "pry"
require_relative "enrollment"
require_relative "district"
require 'json'
require 'ostruct'

class EnrollmentRepository
  attr_accessor :enrollments

  def initialize
    @enrollments = {}
  end

  def load_data(data)
    hash_pathway = {"kindergarten" => "kindergarten_participation", "high_school_graduation" => "high_school_graduation_rates" }
    hash_pathway.each do |key, percentages|
      collection = Hash.new
      CSV.foreach(data[:enrollment][key.to_sym],
                  headers: true, header_converters: :symbol) do |row|
        collection[row[:location]] ||= Hash.new
        collection[row[:location]][row[:timeframe].to_i] = row[:data][0..4].to_f
      end
      collection.each do |location, data|
            enrollment = Enrollment.new(name: location,
                                           percentages.to_sym => data)
        if enrollments[location]
          enrollments[location].school_data[percentages.to_sym] = data
        else
          enrollments[location] = enrollment
        end
      end
    end
  end


  def find_by_name(name)
    data = enrollments.select do |element|
     element.name.downcase == name.downcase
    end
  end
end
