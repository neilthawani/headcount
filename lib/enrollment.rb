class Enrollment
  def initialize(enrollment_data)
    @enrollment_data = enrollment_data # WIP
  end

  e = Enrollment.new(
    name: "ACADEMY 20",
    kindergarten_participation: {
      2010 => 0.3915,
      2011 => 0.35356,
      2012 => 0.2677,
    },
  )

  e # WIP
end
