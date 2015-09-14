class Track < ActiveRecord::Base
  belongs_to :topic
  has_many :lessons

  extend FriendlyId
  friendly_id :name, use: :slugged
  include Extensions::Progressable
  include Extensions::Namable
  include Extensions::Iconable
  
  def type_sorted_lessons
    sorted_lessons = lessons.order(:id).group_by(&:lesson_type)
    formatted_lessons = [[["watch", sorted_lessons["watch"]]], [["challenge", sorted_lessons["challenge"]], ["discussion", sorted_lessons["discussion"]]], [["reading", sorted_lessons["reading"]],["tools", sorted_lessons["tools"]]]]
  end

  def ordered_lessons
    type_sorted_lessons.flatten.reject! {|n| n.class != Lesson}
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

  #for importing tracks to drapertv
  def self.to_draper_tv_chapters
    all.order(:id).map do |track|
      lesson_info = track.ordered_lessons.select { |n| n.lesson_type == "watch"}.map(&:description).join("<br>")
      {track: track, topic_id: track.topic.id, topic_name: track.topic.name, lesson_info: lesson_info}
    end
  end
end
