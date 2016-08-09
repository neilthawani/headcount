require "csv"
require_relative "enrollment"
require_relative "district"

class EnrollmentRepository
  def initialize
    @enrollments = {}
  end

  def load_enrollment_data(array_of_attr_path_hashes)
    array_of_attr_path_hashes.each do |key_path_hash|
      collection = Hash.new
      csv_file = key_path_hash[key_path_hash.keys[0]]

      CSV.foreach(csv_file, headers: true, header_converters: :symbol) do |row|
        district_name = row[:location]
        timeframe = row[:timeframe].to_i
        data = row[:data]

        collection[district_name] ||= Hash.new
        collection[district_name][timeframe] = data[0..4].to_f
      end # CSV.foreach

      collection.each do |district_name, data|
        enrollment = Enrollment.new(name: district_name,
                                    key_path_hash.keys[0] => data)
        if @enrollments[district_name]
          enrollment_data_key = "#{key_path_hash.keys[0].to_s}="
          @enrollments[district_name].send(enrollment_data_key, data)
        else
          @enrollments[district_name] = enrollment
        end # if enrollments[district_name]
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