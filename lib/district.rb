class District
  attr_reader :name

  def initialize(name)
    @name = name[:name]
  end
end

District.new(name: "ACADEMY 20")
