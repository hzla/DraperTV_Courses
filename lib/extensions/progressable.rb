module Extensions
	module Progressable
		
		def completed? user
			return nil if !user
			prog = progress(user)
			return nil if !prog
			prog.percent_complete == 100
		end

		def complete user
			return nil if !user
			user_progress = progress(user)
			if user_progress.percent_complete != 100
				user_progress.update_attributes(percent_complete: 100)
				user_progress.update_percentage_for_parent_progresses user
			end
			self
		end

		def participants
			User.find Progress.where(model_id: id).pluck(:user_id)
		end

		def progress user
			return nil if !user
			Progress.where(model_type: self.class.to_s.downcase, model_id: id, user_id: user.id).first
		end

		def started? user
		    return nil if !user
		    progress_percentage(user) > 0
		end

		def progress_percentage user
		    return 0 if !user
		    selected_progress = progress(user)
		    if selected_progress
		      selected_progress.percent_complete
		    else
		      0
		    end
		end

		def status user
		    return "untouched" if !user
		    percentage = progress_percentage(user)
		    return "completed" if percentage == 100
		    return "started" if percentage > 0
		    return "untouched"
		end

		def progress_info user
			status = "untouched"
		    percentage = progress_percentage(user)
		    status =  "completed" if percentage == 100
		    status =  "started" if percentage > 0
		    {status: status, percentage: percentage}
		end	

		def status_icon user
			completed?(user) ? "done.svg" : "untouched.svg"
		end

	end
end



  
