module LogisticRegression
	def self.sigmoid(z)
		1 / (1 + Math.exp(-z))
	end
end