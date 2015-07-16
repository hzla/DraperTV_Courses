class Topic < ActiveRecord::Base
  attr_accessible :name, :percent_complete, :icon, :order, :percentage
  has_many :tracks

  def status user
    return "untouched" if !user
  	return "completed" if complete?(user)
  	return "started" if started?(user)
  	return "untouched"
  end

  def started? user
    return nil if !user
  	progress(user)
  end

  def complete? user
    return nil if !user
  	progress(user) && progress_percentage(user) == 100
  end

  def done_icon
    done = icon.gsub(".svg", "badge.svg") 
  end

  def progress user
    return nil if !user
    Progress.where(model_id: id, model_type: "topic", user_id: user.id).first
  end

  def progress_percentage user
    return 0 if !user
    if progress user
      progress(user).percent_complete
    else
      0
    end
  end

  def progress_info user
    {status: status(user), percentage: progress_percentage(user)}
  end



end
