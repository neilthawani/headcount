require "csv"
require "pry"
require_relative "enrollment"
require_relative "district"

class StatewideTestRepository
  attr_accessor :statewide_tests

  def initialize
    @statewide_tests = {}
  end

  def load_data(data)
    hash_pathway = {"statewide_testing" => "third_grade", "statewide_testing" => "eighth_grade", "statewide_testing" => "math", "statewide_testing" => "reading", "statewide_testing" => "writing" }

    hash_pathway.each do |key, percentages|
      collection = Hash.new

      CSV.foreach(data[:statewide_test][key.to_sym],
                  headers: true, header_converters: :symbol) do |row|
        collection[row[:location]] ||= Hash.new
        collection[row[:location]][row[:score].to_i][row[:timeframe].to_i] = row[:data][0..4].to_f
      end

      collection.each do |location, data|
            statewide_test = StatewideTest.new(name: location,
                                           percentages.to_sym => data)
        if statewide_tests[location]
          statewide_tests[location].statewide_data[percentages.to_sym] = data
        else
          statewide_tests[location] = statewide_test
        end
      end
    end
  end


  def find_by_name(name)
    if name.nil?
      nil
    else
      data = statewide_tests.find do |element|
        element[1].name.downcase == name.downcase
      end
      data && data[1]
    end
  end
end
