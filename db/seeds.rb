require 'csv'

def people_1(file)
  CSV.foreach(file, options = {:headers => true, :header_converters => :symbol, :converters => :all}) do |row|
    Person.create!({
     gender: row[1] == "M" ? 1 : 0,
     weight: row[2],
     height: row[3]
     })
  end
end

def people_2(file)
  CSV.foreach(file, options = {:headers => true, :header_converters => :symbol, :converters => :all}) do |row|
    Person.create!({
      gender: row[0] == "Male" ? 1 : 0,
      height: row[1],
      weight: row[2]
      })
  end
end


people_1('db/people_1.csv')
# people_2('db/people_2.csv')
