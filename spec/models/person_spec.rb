require "rails_helper"

RSpec.describe Person, :type => :model do
		let(:male) {  Person.create!(height: 182, weight: 77, gender: 1) }
		let(:female) {  Person.create!(height: 157, weight: 59, gender: 0) }
		
		it 'correctly guesses males' do
			male.classify
			# expect(male.guess_gender).to eq("M")
		end

		it 'correctly guesses females' do
			# expect(female.guess_gender).to eq("F")
		end
end