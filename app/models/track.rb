class Track < ActiveRecord::Base
  attr_accessible :name, :percent_complete, :icon, :topic_id, :order, :watch_time, :summary, :video_uid
  belongs_to :topic
  has_many :lessons

  extend FriendlyId
  friendly_id :name, use: :slugged

  def started? user
    return nil if !user
    progress_percentage(user) > 0
  end

  def complete? user
    return nil if !user
    progress_percentage(user) == 100
  end

  def progress user
    return nil if !user
    Progress.where(model_id: id, model_type: "track", user_id: user.id).first
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

  def camel_case_name
    name.downcase.split(" ").map(&:capitalize).join(" ")
  end

  def status user
    return "untouched" if !user
    percentage = progress_percentage(user)
    return "completed" if percentage == 100
    return "started" if percentage > 0
    return "untouched"
  end

  def done_icon
    done = icon.gsub(".svg", "done.svg") 
  end

  def started_icon
    icon
  end

  def progress_info user
    {status: status(user), percentage: progress_percentage(user)}
  end

  def display_name
    name.downcase.split(" ").map(&:capitalize).join(" ")
  end

  def type_sorted_lessons
    sorted_lessons = {}
    lessons.order(:id).each do |lesson|
      if sorted_lessons[lesson.lesson_type]
        sorted_lessons[lesson.lesson_type] << lesson
      else
        sorted_lessons[lesson.lesson_type] = [lesson]
      end
    end
    formatted_lessons = [[["watch", sorted_lessons["watch"]]], [["challenge", sorted_lessons["challenge"]], ["discussion", sorted_lessons["discussion"]]], [["reading", sorted_lessons["reading"]],["tools", sorted_lessons["tools"]]]]
  end


  def ordered_lessons
    type_sorted_lessons.flatten.reject! {|n| n.class != Lesson}
  end

  def participants
    User.find Progress.where(model_id: id).pluck(:user_id)
  end

  def self.to_draper_tv_chapters
    all.order(:id).map do |track|
      lesson_info = track.ordered_lessons.select { |n| n.lesson_type == "watch"}.map(&:description).join("<br>")
      {track: track, topic_id: track.topic.id, topic_name: track.topic.name, lesson_info: lesson_info}
    end
  end

  def self.get_watch_times
    all.each do |track|
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

  def formatted_watch_time
    if watch_time != 0 && watch_time
      if watch_time / 60 < 60
        minutes = watch_time / 60
        minutes = ((minutes / 15) + 1) * 15
        "#{minutes} minutes"
      else
        hours = watch_time / 3600
        if hours == 1
          "#{hours} hour"
        else
          "#{hours} hours"
        end
      end 
    else
      "None"
    end
  end

end
