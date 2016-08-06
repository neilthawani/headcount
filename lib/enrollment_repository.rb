require "csv"
require_relative "enrollment"
require_relative "district"

class EnrollmentRepository
  def initialize
    @enrollments = {}
  end

  def load_data(array_of_attr_path_hashes)
    array_of_attr_path_hashes.each do |key_path_hash|
      collection = Hash.new
      csv_file = key_path_hash[key_path_hash.keys[0]]

      CSV.foreach(csv_file, headers: true, header_converters: :symbol) do |row|
        location = row[:location]
        timeframe = row[:timeframe].to_i
        data = row[:data]

        collection[location] ||= Hash.new
        collection[location][timeframe] = data[0..4].to_f
      end # CSV.foreach

      collection.each do |location, data|
        enrollment = Enrollment.new(name: location,
                                    key_path_hash.keys[0] => data)
        if @enrollments[location]
          @enrollments[location].send("#{key_path_hash.keys[0].to_s}=", data)
        else
          @enrollments[location] = enrollment
        end # if enrollments[location]
      end # collection.each
    end # array_of_attr_path_hashes.each
  end # load_data

  def find_by_name(name)
    if name.nil?
      nil
    else
      enrollment = @enrollments.find do |element|
        element[1].name.downcase == name.downcase
      end

      enrollment && enrollment[1]
    end
  end
end