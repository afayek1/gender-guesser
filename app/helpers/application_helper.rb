module ApplicationHelper
	def mean(arr)
		arr.inject(:+)/arr.length
	end

end
