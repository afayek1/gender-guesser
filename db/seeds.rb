class PersonParser
  attr_reader :people

  def initialize(file)
    @file = file
  end

  def people

    CSV.foreach(@file, options = {:headers => true, :header_converters => :symbol, :converters => :all}) do |row|
     	Person.create!({
     		gender: row[1],
     		weight: row[2],
     		height: row[3]
     	})
    end
  end
end

parser = PersonParser.new('db/people.csv')
parser.people