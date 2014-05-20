class Assignment < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  attr_accessible :description, :preview_url, :title, :vimeo_url, :order_id, :survey_id, :require_upload, :speaker_name, :category, :speaker_bio, :speaker_twitter, :speaker_linkedin, :speaker_angel, :course_id
  attr_accessible :speaker_pic, :user_assignment_id, :question_text, :question_duh_response
  belongs_to :course
  has_many :user_assignments

  has_many :user_comments, as: :commentable
  has_attached_file :speaker_pic,
    :styles => { :large => "200x200#" },
    :default_url => "/assets/missing/missing.png",
    :bucket => 'duhonline'

  def survey
    if self.survey_id.nil?
      return nil
    else
      Survey::Survey.find self.survey_id
    end
  end

  def complete_for_user?(current_user)
    complete = false

    if self.survey
      complete = self.survey.attempts.for_participant(current_user).count > 0
    elsif self.category == "upload"
      if self.user_assignments.where(:user_id => current_user[:id]).exists?
        complete = self.user_assignments.where(:user_id => current_user[:id]).first.text != nil
      end
    elsif self.category == "milestone"
      if self.user_assignments.where(:user_id => current_user[:id]).exists?
        complete = self.user_assignments.where(:user_id => current_user[:id]).first.text != nil
      end
    elsif self.category == "video"
      if self.user_assignments.where(:user_id => current_user[:id]).exists?
        complete = self.user_assignments.where(:user_id => current_user[:id]).first.rating != nil || self.user_assignments.where(:user_id => current_user[:id]).first.question_response != nil
      end
    elsif self.category == "founder"
      if self.user_assignments.where(:user_id => current_user[:id]).exists?
        complete = self.user_assignments.where(:user_id => current_user[:id]).first.rating != nil || self.user_assignments.where(:user_id => current_user[:id]).first.question_response != nil
      end
    elsif self.category == "quiz"
      if self.user_assignments.where(:user_id => current_user[:id]).exists?
        complete = self.user_assignments.where(:user_id => current_user[:id]).first.rating != nil || self.user_assignments.where(:user_id => current_user[:id]).first.question_response != nil
      end
    elsif
      complete = self.user_assignments.where(:user_id => current_user[:id]).count > 0
    end

    return complete
  end


end


