module PeopleHelper
	def render_gender(n)
		n == 1 ? "Male" : "Female"
	end

	def render_probability(n)
		(n*100).round(5).to_s
	end
end
