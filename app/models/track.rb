class Track < ActiveRecord::Base
  attr_accessible :name, :percent_complete, :icon, :topic_id, :order
  belongs_to :topic
  has_many :lessons

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
    lessons.each do |lesson|
      if sorted_lessons[lesson.lesson_type]
        sorted_lessons[lesson.lesson_type] << lesson
      else
        sorted_lessons[lesson.lesson_type] = [lesson]
      end
    end
    formatted_lessons = [[["watch", sorted_lessons["watch"]]],[["reading", sorted_lessons["reading"]],["tools", sorted_lessons["tools"]]], [["challenge", sorted_lessons["challenge"]], ["discussion", sorted_lessons["discussion"]]]]
  end


  def ordered_lessons
    type_sorted_lessons.flatten.reject! {|n| n.class != Lesson}
  end



end
