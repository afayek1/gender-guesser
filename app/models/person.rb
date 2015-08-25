class Person < ActiveRecord::Base

	def self.males
		self.where(gender: "M")
	end

	def self.females
		self.where(gender: "W")
	end

end
