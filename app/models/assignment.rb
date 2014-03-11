# == Schema Information
#
# Table name: assignments
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  description              :text
#  vimeo_url                :string(255)
#  preview_url              :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  course_id                :integer
#  order_id                 :integer          default(0)
#  survey_id                :integer
#  require_upload           :boolean          default(FALSE)
#  speaker_name             :string(255)
#  speaker_bio              :text
#  speaker_linkedin         :string(255)
#  speaker_twitter          :string(255)
#  speaker_angel            :string(255)
#  category                 :string(255)
#  speaker_pic_file_name    :string(255)
#  speaker_pic_content_type :string(255)
#  speaker_pic_file_size    :integer
#  speaker_pic_updated_at   :datetime
#  slug                     :string(255)
#  points                   :integer
#  user_assignment_id       :integer
#

class Assignment < ActiveRecord::Base

 
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  attr_accessible :description, :preview_url, :title, :vimeo_url, :order_id, :survey_id, :require_upload, :speaker_name, :category, :speaker_bio, :speaker_twitter, :speaker_linkedin, :speaker_angel, :course_id
  attr_accessible :speaker_pic, :user_assignment_id
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
    elsif
      complete = self.user_assignments.where(:user_id => current_user[:id]).count > 0
    end

    return complete
  end

end

 
