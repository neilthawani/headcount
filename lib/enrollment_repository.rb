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
    # I'm going to open two files
    # 1. open kindergarten_participation
    # 2. create new enrollment objects just with kindergarten participation
    # 3. open high_school_graduation file
    # 4. if my district is already in enrollments, I want to add high school graduation to it, else I'll create a new enrollment


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

    #binding.pry
  end


  def find_by_name(name)
    if name.nil?
      nil
    else
      data = enrollments.find do |element|
       element[1].name.downcase == name.downcase
    end
      data && data[1]
    end
  end
end
