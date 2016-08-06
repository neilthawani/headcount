require "csv"
require_relative "enrollment"
require_relative "district"

class EnrollmentRepository
  attr_accessor :enrollments

  def initialize
    @enrollments = {}
  end

  def load_data(district_participation_or_graduation_values)
    hash_pathway = {"kindergarten" => "kindergarten_participation",
                  "high_school_graduation" => "high_school_graduation_rates" }

    hash_pathway.each do |key, percentages|
      collection = Hash.new
      csv_file = district_participation_or_graduation_values[:enrollment][key.to_sym]

      CSV.foreach(csv_file, headers: true, header_converters: :symbol) do |row|
        location = row[:location]
        timeframe = row[:timeframe].to_i
        data = row[:data]

        collection[location] ||= Hash.new
        collection[location][timeframe] = data[0..4].to_f
      end

      collection.each do |location, data|
        enrollment = Enrollment.new(name: location, percentages.to_sym => data)
        if enrollments[location]
            enrollments[location].send("#{percentages}=", data)
        else
            enrollments[location] = enrollment
        end
      end
    end
  end

  def find_by_name(name)
    if name.nil?
      nil
    else
      enrollment = enrollments.find do |element|
       element[1].name.downcase == name.downcase
    end
      enrollment && enrollment[1]
    end
  end
end