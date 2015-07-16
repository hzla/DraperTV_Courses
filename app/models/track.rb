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
    if progress user
      progress(user).percent_complete
    else
      0
    end
  end

  def status user
    return "untouched" if !user
    return "completed" if complete?(user)
    return "started" if started?(user)
    return "untouched"
  end

  def done_icon
    done = icon.gsub(".svg", "done.svg") 
  end

  def started_icon
    done = icon.gsub(".svg", "white.svg") 
  end



end
