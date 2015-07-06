class Mod < ActiveRecord::Base
	attr_accessible :name, :order, :track_id
	belongs_to :track
	has_many :lessons


	def percent_complete
		total = lessons.count
		complete = lessons.where(finished: true).count
		percentage = complete / total.to_f * 100
		percentage
	end

	
end
