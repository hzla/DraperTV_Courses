class Course < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  attr_accessible :description, :title, :start_date, :end_date, :intro_vimeo, :length, :badge_vimeo, :tile_image
  attr_accessible :course_icon, :intro_screenshot
  has_attached_file :course_icon,
    :styles => { :large => "200x200#", :badge => "80x80#" },
    :default_url => "/images/icon_missing.png",
    :bucket => 'duhonline',
    :s3_credentials => "#{Rails.root}/config/s3.yml"
  has_attached_file :intro_screenshot,
    :bucket => 'duhonline',
    :s3_credentials => "#{Rails.root}/config/s3.yml"
  has_attached_file :tile_image,
    :bucket => 'duhonline',
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :styles => { :medium => "260x320#", :thumb => "80x80#" }
  has_many :assignments

  def assignment_count
    return self.assignments.count
  end

  def complete_count(current_user)
    count = 0

    self.assignments.each do |assignment|
      if assignment.complete_for_user?(current_user) == true
        count += 1
      end
    end

    return count
  end

  def progress(current_user)
    percent = 0
    count = self.complete_count(current_user).to_f
    all = self.assignment_count.to_f
    percent = count / all * 100
    return percent
  end

  def course_complete_for_user?(current_user)
    course_complete = false

    if self.progress(current_user) == 100.0
      course_complete = true
    end

    return course_complete
  end

  def course_current?
    course_current = false

    if self.start_date <= DateTime.now
      course_current = true
    end
  end

end
