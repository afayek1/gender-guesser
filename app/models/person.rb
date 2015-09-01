class Person < ActiveRecord::Base
	def self.males
		Person.where(gender: ["M","Male"] )
	end

	def self.females
		Person.where(gender: ["F","Female"] )
	end

	

	def guess_gender
		# Base rates
		n_males = Person.where(gender: ["M","Male"] ).count
		n_females = Person.where(gender: ["F","Female"] ).count
		n_samples = (n_males + n_females).to_f
		
		p_male = n_males/n_samples
		p_female = n_females/n_samples

		#Probability of evidence
		population_given_weight = Person.where(weight: self.weight)
		population_given_height = Person.where(height: self.height)
		
		p_weight = population_given_weight.count/n_samples
		p_height = population_given_height.count/n_samples

		# Probability of Likelihood
		n_men_given_weight = population_given_weight.where(gender: ["M", "Male"]).count.to_f
		n_women_given_weight = population_given_weight.count - n_men_given_weight
		n_men_given_height = population_given_height.where(gender: ["M", "Male"]).count.to_f
		n_women_given_height = population_given_height.count - n_men_given_height
		
		p_men_given_weight = n_men_given_weight/population_given_weight.count
		p_women_given_weight = n_women_given_weight/population_given_weight.count
		p_men_given_height = n_men_given_height/population_given_height.count
		p_women_given_height = n_women_given_height/population_given_height.count


		# Naive classification
		p_evidence = (p_weight*p_height)
		p_is_a_man = (p_men_given_weight*p_men_given_height*p_male)/p_evidence
		p_is_a_woman = (p_women_given_weight*p_women_given_height*p_female)/p_evidence		
		
		if p_is_a_man > p_is_a_woman
			self.gender = "M"
			return "M"
		elsif p_is_a_man < p_is_a_woman
			self.gender = "F"
			return "F"
		else
			return "N/A"
		end
	end
end