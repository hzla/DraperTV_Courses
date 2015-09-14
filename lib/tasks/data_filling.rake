namespace :db do
  task :assign_lesson_order => :environment do
    Track.all.each do |track|
		track.ordered_lessons.each_with_index do |lesson, i|
			lesson.update_attributes order: i
		end
	end
  end
end

namespace :db do
  task :get_watch_times => :environment do
    Track.all.each do |track|
      time = track.lessons.pluck(:video_length).map do |length|
        if length 
          length.split(":")[0].to_i * 60 + length.split(":")[-1].to_i
        else
          0
        end
      end.reduce(:+)
      track.update_attributes watch_time: time
    end
  end
end

namespace :db do
  task :get_finished_lesson_ids => :environment do
    User.all.each do |user|
      user.update_attributes finished_lesson_ids: user.progresses.where(model_type: "lesson").pluck(:model_id).uniq.sort
    end
  end
end