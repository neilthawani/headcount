require 'csv'
require 'pry'
require_relative 'district'

class DistrictRepository
   attr_reader :districts

  def initialize
    @districts = []

    runner
  end

  def find_by_name(district)
    found = []
    @districts.each do |d|
      if d == district
        found << District.new({:name => district})
      end
    end
    found[0]
  end

  def find_all_matching(district)

  end

  # def load_data()
    # contents = data[:enrollment][:kindergarten]
    # puts contents # =>
  def parser(contents)
     contents.each do |row|
       districts = row[:location]
       @districts << districts.upcase
     end
   end

  def load_data(enrollment_data)
     kindergarten_csv = enrollment_data[:enrollment][:kindergarten]
     contents = CSV.open kindergarten_csv, headers: true, header_converters: :symbol
     parser(contents)
  end

  def runner
    load_data({
      :enrollment => {
        :kindergarten => "../data/Kindergartners in full-day program.csv"
      }
    })
  end
end

#DistrictRepository.new.find_by_name('ACADEMY 20')
