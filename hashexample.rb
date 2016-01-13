require 'CSV'
require 'pry'

some_hash = {} #Hash.new(0)

CSV.foreach("data/School-aged children in poverty.csv") do |line|
  line[0]  #location
  some_hash[line[0]] += 1
  if some_hash[line[0]]
    if some_hash[line[0]][line[1]]
      some_hash[line[0]][line[1]] += 1
    else
      some_hash[line[0]][line[1]] = 1
    end
  else
    some_hash[line[0]] = line[1]
  end

end

#hash value pair all districts have count
{"academy 20" => 24}


{
  "academy 20" => {
    2010 =>2,
    2012 =3
  }
}
