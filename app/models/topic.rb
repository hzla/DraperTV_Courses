class Topic < ActiveRecord::Base
  has_many :tracks

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  include Extensions::Progressable
  include Extensions::Namable
  include Extensions::Iconable

  	def self.progress_infos user, models=Topic.all
		model_ids = models.map(&:id).sort
		class_name = models.first.class.to_s.downcase
		progresses = Progress.where("model_id in (?)", model_ids).where(model_type: class_name, user_id: user.id).order(:model_id)
		models.map.with_index do |model, i|
			status = "untouched"
			if progresses[i]
		    	percentage = progresses[i].percent_complete
		    else
		    	percentage = 0
		    end
		    status =  "completed" if percentage == 100
		    status =  "started" if percentage > 0
			[model, {status: status, percentage: percentage}]
		end.sort_by {|n| n[0].order }
	end
end
