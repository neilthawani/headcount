require "csv"
require "pry"
require_relative "district"

class DistrictRepository
  attr_reader :districts, :district_key

  def initialize
    @districts = {}
    runner
  end

  def find_by_name(name)
    pair = districts.detect do |_key, value|
      name.strip.upcase == value.name.upcase
    end
    pair && pair[1]
  end

  def find_all_matching(name_fragment)
    matching = districts.select do |_key, value|
      value.name.upcase.include?(name_fragment.upcase)
    end
    matching.valuesk
  end

  def parser(contents)
    contents.each do |row|
      district = row[:location]
      districts[district.to_sym] = District.new(name: district)
    end
  end

  def load_data(district_data)
    kindergarten_csv = district_data.fetch(:enrollment).fetch(:kindergarten)
    contents = CSV.open kindergarten_csv, headers: true,
                                          header_converters: :symbol
    parser(contents)
  end

  def runner
    path = File.expand_path("../data/Kindergartners in full-day program.csv", __dir__)
    load_data enrollment: { kindergarten: path }
  end
end
