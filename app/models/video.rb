# == Schema Information
#
# Table name: videos
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  description              :text
#  vimeo_url                :string(255)
#  preview_url              :string(255)
#  order_id                 :integer
#  speaker_name             :string(255)
#  speaker_bio              :text
#  speaker_linkedin         :string(255)
#  speaker_twitter          :string(255)
#  speaker_angel            :string(255)
#  category                 :string(255)
#  slug                     :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  speaker_pic_file_name    :string(255)
#  speaker_pic_content_type :string(255)
#  speaker_pic_file_size    :integer
#  speaker_pic_updated_at   :datetime
#  video_pic_file_name      :string(255)
#  video_pic_content_type   :string(255)
#  video_pic_file_size      :integer
#  video_pic_updated_at     :datetime
#

class Video < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end

  attr_accessible :category, :description, :order_id, :preview_url, :slug, :speaker_angel, :speaker_bio, :speaker_linkedin, :speaker_name, :speaker_twitter, :title, :vimeo_url, :speaker_pic, :video_pic
  has_many :user_comments, as: :commentable
  validates_presence_of :slug
  has_attached_file :speaker_pic, 
    :styles => { :large => "300x300#" }, 
    :default_url => "/images/icon_missing.png",
    :bucket => 'duhonline'
  has_attached_file :video_pic, 
    :styles => { :large => "300x300#" }, 
    :default_url => "/images/icon_missing.png",
    :bucket => 'duhonline'
end
