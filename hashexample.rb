require 'CSV'
require 'pry'

some_hash = {} #Hash.new(0)
CSV.foreach("data/School-aged children in poverty.csv") do |line|
 if some_hash[line[0]]
   some_hash[line[0]] += 1
 else
   some_hash[line[0]] = 0
 end
 puts some_hash

end

#hash value pair all districts have count
