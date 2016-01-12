class District
  attr_reader :name

  def initialize(name)
    @name = name[:name]
  end
end

d = District.new({:name => 'ACADEMY 20'}) # => #<District:0x007fe191022db0 @name="ACADEMY">
