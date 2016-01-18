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
    hash_pathway = {"kindergarten" => "kindergarten_participation", "high_school_graduation" => "high_school_graduation_rates" }
    collection = Hash.new
    hash_pathway.each do |key, percentages|
      CSV.foreach(data[:enrollment][key.to_sym],
                  headers: true, header_converters: :symbol) do |row|
        collection[row[:location]] ||= Hash.new
        collection[row[:location]][row[:timeframe].to_i] = row[:data][0..4].to_f
      end
      collection.map do |location, data|
            enrollments << Enrollment.new(name: location,
                                           percentages.to_sym => data)
      end
    end
  end

  # def merge
  #   enrollments.detect do |enrollment|
  #     require "pry"; binding.pry
  #
  #     end


  # end

  # def squash(data)
  #     h = data.map do |e|
  #       {name: e.name, kp: e.kindergarten_participation, hs: e.high_school_graduation_rates}
  #     end
  ​
      # h.map do |hash|
      #   hash.delete_if{|k,v| v.nil?}
      #   hash
      # end
  ​
  #     h.reduce({}) do |acc , hash|
  #       acc.merge(hash) do |k,v1,v2|
  #         v1 || v2
  #       end
  #     end
  # ​
  #   end
  ​
      #  [{name:1 kp:2 hs:3}, {name:0 kp:1 hs:nil}].merge # =>
      #     [3 ,4 ,5 ,6 , 6, ...]
  ​
      #a.merge(b)
  ​
  ​
  # def find_by_name(name)
  #     data = enrollments.select do |element|
  #      element.name.downcase == name.downcase
  #     end
  #     binding.pry
  #       squash(data)
  #   end
  def find_by_name(name)
    enrollments.detect do |element|
     element.name.downcase == name.downcase
    end
  end
end
