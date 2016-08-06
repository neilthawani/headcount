class District
  attr_reader :name
  attr_accessor :enrollment_data

  def initialize(name)
    @name = name[:name]
  end

  def calculate_kinder_average
    participation_values = enrollment_data.kindergarten_participation.values
    total_enrollment = participation_values.reduce(:+)

    average_district_percentage = total_enrollment / participation_values.count
    average_district_percentage.round(3)
   end

  def calculate_hs_grad_average
    if enrollment_data.high_school_graduation_rates == nil
      grad_rates = 0.5
    else
      grad_rates = enrollment_data.high_school_graduation_rates.values

      total_grad_rate = grad_rates.map {|grad_rate| grad_rate.to_f }.reduce(:+)

      average_grad_rate = total_grad_rate/grad_rates.count

      average_grad_rate.round(3)
    end
  end
end
